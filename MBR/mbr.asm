; Bootsektor ładowany jest pod 0000:7C00, rejestry segmentowe ustawione są na 0
org 0x7C00
start:
    mov ax,0x0013   ; Funkcja 00 (Set mode), tryb 13h (320x200 - 256kolorów)
    int 0x10

    mov ax,0xA000       ; Adres pamięci karty VGA to A000:0000
    mov fs,ax           ; Ustawiamy sobie tam segment FS (nowe procki)
    xor di,di           ; Zerowanie DI (offset punktu w pamięci obrazu)
    xor bx,bx           ; Zerowanie BX (liczy X)
    xor cx,cx           ; Zerowanie CX (liczy Y)

    LOP:
        ; Long story short - iloczyn bitowy współrzędnych generuje strukturę
        ; graficzną trójkąta Sierpińskiego. Przy kolorach efekt jest, hm,
        ; oryginalny...
        mov ax,bx           ; Pierwsza współrzędna do AX...
        and ax,cx           ; ... i AND-ujemy ją z drugą współrzędną

        ; Wpisanie numeru koloru do pamięci obrazu
        mov [fs:di],al      ; pod adres FS:DI wrzuć zawartość AL

        ; Wyliczamy nowe współrzędne
        inc bx              ; Następny X
        cmp bx,320          ; Czy koniec rzędu ...
        jne NO_ROW_END      ; ... nie - pomiń następne
            xor bx,bx       ; Zeruj X
            inc cx          ; Następny Y

        NO_ROW_END:

        inc di              ; Następny adres
        cmp di,320*200      ; Czy wszystkie pixele?
    jne LOP                 ; Jak nie, to pętla

	mov	bp,SPACES   ; Offset spacji
    mov dh,9        ; Wiersz 9
    call PRINT      ; Wydrukuj wyśrodkowane

	mov	bp,MSG      ; Offset napisu
    mov dh,10       ; Wiersz 9
    call PRINT      ; Wydrukuj wyśrodkowane

	mov	bp,SPACES   ; Offset spacji
    mov dh,11       ; Wiersz 11
    call PRINT      ; Wydrukuj wyśrodkowane

    hlt                 ; Zatrzymanie procesora

PRINT:
    mov	cx,MSGL         ; Długość napisu
    mov bh,0            ; Strona (0 dla trybów graficznych)
	mov	bl,14	        ; Kolor z palety VGA (14=żółty)
    mov dl,20-MSGL/2    ; Kolumna tak, aby wyśrodkować
	mov	ax,0x1300	    ; Wypisz, nie przesuwaj kursora
	int	0x10
    ret

MSG:     db " Hello LinuX-Lab! "    ; Napis
MSGL:    equ $-MSG                  ; Długość napisu (adres 'tutaj' - adres MSG)
SPACES:  times MSGL db " "          ; Tyle spacji, ile ma napis

    times 446-($-$$) db 0 ; wypełnienie zerami do bajtu 446

; ------------------------------------------------------------------------------
; Normalnie tutaj jest tablica partycji. Ten bootblock NIE MA jej. Dysk jest
; mimo tego bootowalny.
PART_TABLE:
; ------------------------------------------------------------------------------

    times 510-($-$$) db 0 ; wypełnienie zerami do bajtu 510

; ------------------------------------------------------------------------------
; Ostatnie 2 bajty muszą zawierać konkretną stałą, żeby być MBR-em
MBR_TAG:
    dw 0xAA55
; ------------------------------------------------------------------------------
