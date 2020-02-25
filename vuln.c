#include <stdio.h>
#include <string.h>

void secret_function(void) {
    printf("this is secret!\n");
}

void check_password(const char *password) {
    char buff[128];

    // some cheating
    printf("buff is @ %p\n", buff);
    strcpy(buff, password);

    if(strcmp(buff, "secret")) {
        printf ("Wrong Password\n");
    } else {
        printf("Correct Password\n");
        secret_function();
    }
}

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("usage: %s <password>\n", argv[0]);
        return 0;
    }

    check_password(argv[1]);

    return 0;
}
