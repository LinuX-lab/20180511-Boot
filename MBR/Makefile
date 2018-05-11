all: qemu

clean:
	@rm *.bin

mbr: mbr.bin

qemu: mbr.bin
	qemu-system-i386 -hda $<

%.bin: %.asm
	nasm -f bin $^ -o $@
