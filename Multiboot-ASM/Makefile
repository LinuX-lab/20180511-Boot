#!/usr/bin/make -f

all: qemu

qemu: boot.iso
	qemu-system-i386 -cdrom $<

clean:
	rm -f kernel.bin *.o iso/boot/kernel.bin

dump: kernel.bin
	objdump --all -sd -Mintel $<

kernel.bin:	header.o boot.o
	ld -nostdlib -n -o $@ -T linker.ld $^
	# -melf_i386

%.o: %.asm
	nasm -f elf32 $^ -o $@

%.o: %.c
	gcc -fno-pic -fno-pie -m32 -O4 -fno-unwind-tables -fno-asynchronous-unwind-tables -c -fno-asynchronous-unwind-tables $^ -o $@

iso/boot/kernel.bin: kernel.bin
	cp $< $@

boot.iso: iso/boot/kernel.bin
	grub-mkrescue -d /usr/lib/grub/i386-pc -o $@ iso
