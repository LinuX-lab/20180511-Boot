# "Sekcja" przydziela blok kodu/danych do nazwanej grupy
section .multiboot_header
header_start:
    dd 0xe85250d6                ; Identyfikator MultiBoot2 (magiczna stała)
    dd 0                         ; Architektura 0 (32-bitowy, chroniony, IA32 )
    dd header_end - header_start ; Długość nagłówka
    ; Suma kontrolna
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; Tagi

    ; Wymagany tag końcowy
    dw 0    ; typ
    dw 0    ; flagi
    dd 8    ; rozmiar
header_end:
