ENTRY(start)

/* Define sections of binary */
SECTIONS 
{
    /* Kernel loaded */
    . = 1M;

    .boot : 
    {
        /* header */
        KEEP(*(.multiboot_header))
    }

    .text : 
    {
        /* CPU instruct */
        *(.text)
    }
}