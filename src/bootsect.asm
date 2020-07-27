[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov ax, 0x0000
mov es, ax    
mov ds, ax
mov ax, 0x0000
cli
mov ss, ax
mov sp, 0x9000
sti
mov bx, MSG_REAL_MODE
call print
call print_nl

call load_kernel

mov bx, MSG_SWITCH
call print
call print_nl
call switch_to_pm
jmp $

%include "asm_utils/boot_sect_print.asm"
%include "asm_utils/boot_sect_print_hex.asm"
%include "asm_utils/boot_sect_disk.asm"
%include "asm_utils/32bit_gdt.asm"
%include "asm_utils/32bit_print.asm"
%include "asm_utils/32bit_switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; give control to the kernel
    jmp $


BOOT_DRIVE db 0
MSG_REAL_MODE db "In 16b Real Mode", 0
MSG_SWITCH db "Switching to 32b protected mode", 0
MSG_PROT_MODE db "Landed in 32b protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel from disk", 0
; padding
times 510 - ($-$$) db 0
dw 0xaa55

;sector padding
times 256 dw 0xDADA