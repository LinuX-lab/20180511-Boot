GLOBAL start
SECTION .text
BITS 32

VIDEO_MEMORY            equ 0xb8000

start:
	mov dword [VIDEO_MEMORY],0x2f4b2f4f
	hlt
	
