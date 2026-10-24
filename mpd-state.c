#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

typedef char			   i8;
typedef short int		   i16;
typedef int				   i32;
typedef long int		   i64;
typedef unsigned char	   u8;
typedef unsigned short int u16;
typedef unsigned int	   u32;
typedef unsigned long int  u64;

#define TERMINATE        \
	printf("[H[?25h"); \
	return 0
#define GET_OPTION(a)                     \
	while (fgets(a, sizeof(a), output)) { \
		removechar(a, '\n');              \
		break;                            \
	}

#define MIN(a, b) ((a < b) ? a : b)
#define MAX(a, b) ((a > b) ? a : b)

#define wait(bytes) \
	for (int i = 0; i < bytes; ++i) printf("[H");

// TEXT FORMAT FUNCTION GOT FROM RAYLIB (https://github.com/raysan5/raylib/blob/master/src/rtext.c)
char* textFormat(const char* text, ...) {
#define MAX_TEXT_BUFFER_LENGTH 1024
#define MAX_TEXTFORMAT_BUFFERS 4  // Maximum number of static buffers for text formatting
	// Create an array of buffers so strings don't expire until MAX_TEXTFORMAT_BUFFERS invocations
	static char buffers[MAX_TEXTFORMAT_BUFFERS][MAX_TEXT_BUFFER_LENGTH] = {0};
	static int	index = 0;

	char* currentBuffer = buffers[index];
	memset(currentBuffer, 0, MAX_TEXT_BUFFER_LENGTH);  // Clear buffer before using

	if (text != NULL) {
		va_list args;
		va_start(args, text);
		int requiredByteCount = vsnprintf(currentBuffer, MAX_TEXT_BUFFER_LENGTH, text, args);
		va_end(args);

		// If requiredByteCount is larger than the MAX_TEXT_BUFFER_LENGTH, then overflow occurred
		if (requiredByteCount >= MAX_TEXT_BUFFER_LENGTH) {
			// Inserting "..." at the end of the string to mark as truncated
			char* truncBuffer = buffers[index] + MAX_TEXT_BUFFER_LENGTH - 4;  // Adding 4 bytes = "...\0"
			snprintf(truncBuffer, 4, "...");
		}

		index += 1;	 // Move to next buffer for next function call
		if (index >= MAX_TEXTFORMAT_BUFFERS) index = 0;
	}

	return currentBuffer;
}
// https://stackoverflow.com/questions/7821997/ddg#7822057
void removechar(char str[], char t) {
	int i, j;
	i = 0;
	while (i < strlen(str)) {
		if (str[i] == t) {
			for (j = i; j < strlen(str); j++)
				str[j] = str[j + 1];
		} else i++;
	}
}

typedef struct rgb {
	i64 r;
	i64 g;
	i64 b;
} rgb;
rgb hexToRgb(char hex[7]) {
	rgb	 RGB;
	char r[3];
	char g[3];
	char b[3];

	if (hex[0] == '#') {
		r[0] = hex[1];
		r[1] = hex[2];
		r[2] = '\0';
		g[0] = hex[3];
		g[1] = hex[4];
		g[2] = '\0';
		b[0] = hex[5];
		b[1] = hex[6];
		b[2] = '\0';
	} else {
		r[0] = hex[0];
		r[1] = hex[1];
		r[2] = '\0';
		g[0] = hex[2];
		g[1] = hex[3];
		g[2] = '\0';
		b[0] = hex[4];
		b[1] = hex[5];
		b[2] = '\0';
	}

	i64 R = strtol(r, NULL, 16);
	i64 G = strtol(g, NULL, 16);
	i64 B = strtol(b, NULL, 16);

	RGB.r = R;
	RGB.g = G;
	RGB.b = B;

	return RGB;
}

char* printrgb(rgb color, int bg) {
	if (bg) return textFormat("[48;2;%ld;%ld;%ldm", color.r, color.g, color.b);
	return textFormat("[38;2;%ld;%ld;%ldm", color.r, color.g, color.b);
}

struct termios orig_termios;

void die(const char* s);
void disableRawMode() {
	if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios) == -1)
		die("tcsetattr");
}
void enableRawMode() {
	if (tcgetattr(STDIN_FILENO, &orig_termios) == -1) die("tcgetattr");
	atexit(disableRawMode);
	struct termios raw = orig_termios;
	raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
	raw.c_oflag &= ~(OPOST);
	raw.c_cflag |= (CS8);
	raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
	raw.c_cc[VMIN] = 0;
	raw.c_cc[VTIME] = 5;
	if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw) == -1) die("tcsetattr");
}
void die(const char* s) {
	printf("[H%s", s);
	wait(0xffffff);
	disableRawMode();
	exit(1);
}

i16 columns;
i16 rows;

int main() {
	printf("[H[2J[?25l");

	// COLORS
	rgb mauve = hexToRgb("#c6a0f6");
	rgb yellow = hexToRgb("#eed49f");
	rgb text = hexToRgb("#cad3f5");
	rgb dim = hexToRgb("#8087a2");
	rgb blue = hexToRgb("#8aadf4");
	rgb bg = hexToRgb("#181926");

	int in = 1;
	int start;

	FILE* output;
	output = popen("tput cols", "r");
	char cols[0xff];
	GET_OPTION(cols);

	output = popen("tput lines", "r");
	char lines[0xff];
	GET_OPTION(lines);
	columns = strtol(cols, NULL, 10);
	rows = strtol(lines, NULL, 10);
	start = rows;

	while (start >= 0) {
		wait(0xffff);
		printf("[H[0m%s%s", printrgb(bg, 1), printrgb(mauve, 0));
		if (start == 0) printf("╭");
		else printf("[%dB╭", start);
		for (int i = 0; i < columns - 2; ++i) {
			printf("─");
		}
		start--;
		printf("╮[H\n");
		if (start < rows) {
			printf("[H[%dB[2K[H\n", start + 2);
			for (int i = start; i <= rows - 1; ++i) {
				printf("[H[%dB%s%s│[%dG%s%s│[H\n", i + 2, printrgb(bg, 1), printrgb(mauve, 0), columns, printrgb(bg, 1), printrgb(mauve, 0));
			}
		}
	}

	char bName[0xff];

	output = popen("echo $HOME", "r");
	char home[0xff];
	GET_OPTION(home);

	enableRawMode();
	while (in) {
		output = popen("tput cols", "r");
		GET_OPTION(cols);

		output = popen("tput lines", "r");
		GET_OPTION(lines);
		columns = strtol(cols, NULL, 10);
		rows = strtol(lines, NULL, 10);

		output = popen("mpc -f %title% current", "r");
		char name[0xff];
		GET_OPTION(name);

		output = popen("mpc -f %artist% current", "r");
		char artist[0xff];
		GET_OPTION(artist);

		output = popen("mpc status %volume%", "r");
		char vol[0xff];
		GET_OPTION(vol);
		int volume = strtol(vol, NULL, 10);

		output = popen("mpc status %repeat%", "r");
		char repeat[0xff];
		GET_OPTION(repeat);

		output = popen("mpc status %random%", "r");
		char random[0xff];
		GET_OPTION(random);

		output = popen("mpc status %consume%", "r");
		char consume[0xff];
		GET_OPTION(consume);

		output = popen("mpc status %single%", "r");
		char single[0xff];
		GET_OPTION(single);

		output = popen("mpc status %totaltime%", "r");
		char tt[0xff];
		GET_OPTION(tt);

		output = popen("mpc status %currenttime%", "r");
		char ct[0xff];
		GET_OPTION(ct);

		output = popen("mpc status %state%", "r");
		char state[0xff];
		GET_OPTION(state);

		char cp[sizeof(ct)];
		int	 ctime;
		int	 j = 0;
		for (int i = 0; i < (int)strlen(ct); ++i) {
			if (ct[i] == ':') {
				cp[i] = '\0';
				ctime = strtol(cp, NULL, 10);
				cp[0] = '\0';
				j = i + 1;
			}
			cp[i - j] = ct[i];
			if (i == strlen(tt) - 1) {
				ctime *= 60;
				ctime += strtol(cp, NULL, 10);
			}
		}
		char tp[sizeof(tt)];
		int	 ttime;
		j = 0;
		for (int i = 0; i < (int)strlen(tt); ++i) {
			if (tt[i] == ':') {
				tp[i] = '\0';
				ttime = strtol(tp, NULL, 10);
				tp[0] = '\0';
				j = i + 1;
			}
			tp[i - j] = tt[i];
			if (i == strlen(tt) - 1) {
				ttime *= 60;
				ttime += strtol(tp, NULL, 10);
			}
		}

		int progress = (int)((ctime / (float)ttime) * (columns - strlen(ct) - strlen(tt)) - 4);

		columns -= 2;
		rows--;
		if (strcmp(bName, name) != 0) {
			for (int i = 0; i < (int)sizeof(bName); ++i) {
				bName[i] = name[i];
			}
			if (system("mkdir -p ~/.config/mpd/state") != 0) die("system\n");
			if (system("rmpc albumart -o ~/.config/mpd/state/albumart.png") != 0) die("system\n");
			if (system(textFormat("timg -p h -g%dx%d -C ~/.config/mpd/state/albumart.png -o ~/.config/mpd/state/albumart.txt", columns, rows - 4)) != 0) die("system\n");
		}
		printf("%s", printrgb(bg, 1));
		printf("[2J[H%s╭", printrgb(mauve, 0));
		for (int i = 0; i < columns; ++i) {
			printf("─");
		}
		printf("╮[1G\n");
		printf("%s", printrgb(bg, 1));
		disableRawMode();
		output = fopen(textFormat("%s/.config/mpd/state/albumart.txt", home), "r");
		if (output == NULL) {
			die("no albumart\n");
		}
		char albumart[0xff];
		printf("[H\n");
		while (fgets(albumart, sizeof(albumart), output)) {
			printf("%s", albumart);
		}
		enableRawMode();
		printf("[?25l");
		printf("[H[1B[%dB", rows - 4);
		printf("%s", printrgb(bg, 1));
		printf("%s%*s%s - %s%s%*s", printrgb(yellow, 0), (int)(columns + strlen(artist) - 3 - strlen(name)) / 2, artist, printrgb(text, 0), printrgb(mauve, 0), name, (int)(columns + strlen(artist) - 3 - strlen(name)) / 2, " ");
		printf("%s", printrgb(bg, 1));
		printf("[H[1B[%dB", rows - 3);
		printf("[2G[%dG", (columns - 14) / 2);
		printf("%s%s%s ", (strcmp(repeat, "on") == 0) ? printrgb(blue, 0) : printrgb(bg, 0), " ", printrgb(bg, 1));
		printf("%s%s%s ", (strcmp(random, "on") == 0) ? printrgb(blue, 0) : printrgb(bg, 0), " ", printrgb(bg, 1));
		printf(" %s%s%s  ", printrgb(mauve, 0), (strcmp(state, "playing") == 0) ? " " : " ", printrgb(bg, 1));
		printf("%s%s%s ", (strcmp(consume, "on") == 0) ? printrgb(blue, 0) : printrgb(bg, 0), "󰮯 ", printrgb(bg, 0));
		printf("%s%s%s ", (strcmp(single, "on") == 0 || strcmp(single, "once") == 0) ? ((strcmp(single, "once") == 0) ? printrgb(yellow, 0) : printrgb(blue, 0)) : printrgb(bg, 0), "󰎤 ", printrgb(bg, 0));
		printf("[0m\n");
		printf("[H[1B[%dB ", rows - 2);
		printf("%s", printrgb(bg, 1));
		printf("[2K[2G%s󰕾 %s%.*s %s[0m%s%.*s %s%d%%\n", printrgb(blue, 0), printrgb(mauve, 0), (int)((columns * volume / 100) - 2 - strlen(vol) - 2) - 2, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", printrgb(text, 0), printrgb(bg, 1), (int)(columns - 4 - strlen(vol)) - (int)((columns * volume / 100) - 2 - strlen(vol) - 2), "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", printrgb(blue, 0), volume);
		printf("%s", printrgb(bg, 1));
		printf("[H[1B[%dB ", rows - 1);
		if (progress <= 0) printf("%s%s    %s%*s[0m%s[H\n", ct, printrgb(bg, 1), printrgb(blue, 0), (int)(columns - strlen(ct) - strlen(tt)), tt, printrgb(bg, 1));
		else if (progress == 1) printf("%s [0m%s%s   %s%*s[0m%s[H\n", ct, printrgb(bg, 1), printrgb(mauve, 0), printrgb(blue, 0), (int)(columns - strlen(ct) - strlen(tt) - progress), tt, printrgb(bg, 1));
		else if (progress == 2) printf("%s [0m%s%s   %s%*s[0m%s[H\n", ct, printrgb(bg, 1), printrgb(mauve, 0), printrgb(blue, 0), (int)(columns - strlen(ct) - strlen(tt) - progress), tt, printrgb(bg, 1));
		else printf("%s %s%s%*s[0m%s%s %s[%dG%s[0m%s[H\n", ct, printrgb(mauve, 0), printrgb(mauve, 1), progress, " ", printrgb(bg, 1), printrgb(mauve, 0), printrgb(blue, 0), columns + 2 - (int)strlen(tt), tt, printrgb(bg, 1));

		for (int i = 1; i <= rows; ++i) {
			printf("[H[%dB%s%s│[0m[H\n", i, printrgb(bg, 1), printrgb(mauve, 0));
			printf("[H[%dB[%dG%s%s│[0m[H\n", i, columns + 2, printrgb(bg, 1), printrgb(mauve, 0));
		}

		char c = '\0';
		if (read(STDIN_FILENO, &c, 1) == -1 && errno != EAGAIN) die("read");
		switch (c) {
			case 'p':
				if (system("mpc -q toggle") != 0) die("system\n");
				break;
			case 'f':
				if (system("mpc -q seek +5") != 0) die("system\n");
				break;
			case 'b':
				if (system("mpc -q seek -5") != 0) die("system\n");
				break;
			case '>':
				if (system("mpc -q next") != 0) die("system\n");
				break;
			case '<':
				if (system("mpc -q prev") != 0) die("system\n");
				break;
			case ',':
				if (system("mpc -q volume -5") != 0) die("system\n");
				break;
			case '-':
				if (system("mpc -q volume -5") != 0) die("system\n");
				break;
			case '.':
				if (system("mpc -q volume +5") != 0) die("system\n");
				break;
			case '+':
				if (system("mpc -q volume +5") != 0) die("system\n");
				break;
			case 'z':
				if (system("mpc -q repeat") != 0) die("system\n");
				break;
			case 'x':
				if (system("mpc -q random") != 0) die("system\n");
				break;
			case 'c':
				if (system("mpc -q consume") != 0) die("system\n");
				break;
			case 'v':
				if (system("mpc -q single") != 0) die("system\n");
				break;

			case 'q':
				in = 0;
				break;
			case '':
				in = 0;
				break;
			case '':
				in = 0;
				break;
			case '':
				in = 0;
				break;
		}
	}
	disableRawMode();
	start = rows;
	while (start >= 0) {
		wait(0xffff);
		printf("[H[0m%s%s", printrgb(bg, 1), printrgb(mauve, 0));
		if (start == rows) printf("╭");
		else printf("[%dB╭", rows - start);
		for (int i = 0; i < columns; ++i) {
			printf("─");
		}
		start--;
		printf("╮[H\n");
		if (start < rows) printf("[0m[H[%dB[2K[H\n", rows - start - 2);
	}
	wait(0xffff);
	TERMINATE;
}
