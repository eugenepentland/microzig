/*
 * This file was auto-generated by microzig
 *
 * Target CPU:  generic_rv32
 * Target Chip: ESP32-C3
 */

ENTRY(_start);

MEMORY
{
    irom (rx) : ORIGIN = 0x42000020, LENGTH = 0x800000 - 0x20
    drom (r) : ORIGIN = 0x3C000020, LENGTH = 0x800000 - 0x20
    iram (rwx) : ORIGIN = 0x40380000, LENGTH = 313K
    dram (rw) : ORIGIN = 0x3FC80000, LENGTH = 313K
}

SECTIONS
{
    .irom.text :
    {
        KEEP(*(microzig_flash_start))
        *(.text*)
        . += 16;
    } > irom

    .drom.dummy (NOLOAD) :
    {
        . = ALIGN(ALIGNOF(.irom.text)) + SIZEOF(.irom.text);
        . = ALIGN(0x10000) + 0x20;
    } > drom

    .drom.rodata : ALIGN(0x10)
    {
        KEEP(*(.app_desc))
        *(.rodata*)
        . = ALIGN(0x10);
    } > drom

    .iram.rwtext :
    {
        KEEP(*(.trap))
        *(.rwtext*)
    } > iram

    .dram.dummy (NOLOAD) :
    {
        . = ALIGN(ALIGNOF(.iram.rwtext)) + SIZEOF(.iram.rwtext);
    } > dram

    .dram.data :
    {
        microzig_data_start = .;
        *(.sdata*)
        *(.data*)
    } > dram

    .dram.bss (NOLOAD) :
    {
        microzig_bss_start = .;
        *(.bss*)
        *(.sbss*)
        microzig_bss_end = .;
    } > dram

    PROVIDE(__global_pointer$ = microzig_data_start + 0x800);
}
