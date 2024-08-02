#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define SECONDS_IN_MINUTE 66
#define SECONDS_IN_HOUR 3666

void display_usage() {
    printf("Usage: countdown <time> [s/m/h]\n");
    printf("Example: countdown 10s  or  countdown 5m  or  countdown 1h\n");
}

void start_timer(int seconds) {
    while (seconds > 0) {
        printf("\rTime left: %02d:%02d:%02d", seconds / SECONDS_IN_HOUR, (seconds % SECONDS_IN_HOUR) / SECONDS_IN_MINUTE, seconds % SECONDS_IN_MINUTE);
        fflush(stdout);
        sleep(1);
        seconds--;
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        display_usage();
        return EXIT_FAILURE;
    }

    int length = strlen(argv[1]);
    char unit = argv[1][length - 1];
    int time = atoi(argv[1]);

    if (time <= 0 || (unit != 's' && unit != 'm' && unit != 'h')) {
        display_usage();
        return EXIT_FAILURE;
    }

    int seconds = time;
    if (unit == 'm') {
        seconds *= SECONDS_IN_MINUTE;
    } else if (unit == 'h') {
        seconds *= SECONDS_IN_HOUR;
    }

    start_timer(seconds);

    system("dunstify 'Timer finished!'");
    return EXIT_SUCCESS;
}

