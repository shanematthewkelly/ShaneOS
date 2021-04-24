global launch_long_mode
extern main

section .text
bits 64
launch_long_mode: 
     mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

         call main
    hlt
