/* Od tego symbolu zaczyna się program */
ENTRY(start)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)
TARGET(elf32-i386)
SECTIONS {
    /* "Przewiń" bieżący wskaźnik do 1MB */
    . = 1M;

    /* Zawartość bloku BOOT */
    .boot :
    {
        /* Zawiera wszystkie sekcje multiboot_header */
        *(.multiboot_header)
    }

    /* Zawartość bloku BOOT */
    .text :
    {
        /* Zawiera wszystkie sekcje text */
        *(.text .text.*)
        *(.rodata .rodata.*)
        *(.data .data.*)
    }
    PROVIDE(__bss_start = .);
    .bss : { *(.bss) *(COMMON) }
    PROVIDE(end = .);

    /DISCARD/ : { *(*) }
}
