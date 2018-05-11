/*
    Całkowicie "gołe" środowisko, bez runtime'a, bez biblioteki standardowej,
    no nothin'
*/

/* pamięć ekranu */
 unsigned short *const SCR = (unsigned short *)0xb8000;

/* Wypisz znak w konkretnym miejscu i kolorze */
inline void charxy(char x, char y, char c, char a) {
    SCR[x + 80 * y] = ((unsigned short)(a)) << 8 | c;
}

/* Wypisz string w konkretnym miejscu i kolorze */
 void printxy(char x, char y, const char *str, char a) {
    while (*str != 0) {
        charxy(x, y, *str, a);
        x++;
        if (x >= 80) {
            y++;
            x = 0;
        }
        str++;
    }
}

/* główna funkcja */
void start()  {

    /* czyszczenie ekranu */
    for (int x = 0; x < 80 * 25; x++) { SCR[x] = 0; }

    /* napis */
    printxy(10, 10, "LinuX-Lab", 0x2f);

    /* zawieszenie */
    while (1) {}
}

