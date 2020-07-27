; Enter 32 bit real mode
[bits 16]
switch_to_pm:
    ; mov ax, 0x0
    ; mov ds, ax
    cli   ; disable interrupts
    lgdt [gdt_descriptor]  ; load the GDT
    mov eax, cr0
    or al, 0x1   ; set 32 bit mode in cr0
    mov cr0, eax
    jmp CODE_SEG:init_pm ; far jump by using a different segment (flushes pipeline)

[bits 32]
init_pm: ; now using 32bit instructions
    mov ax, DATA_SEG ; update the segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x9000 ;update the stack right
    mov esp, ebp

    call BEGIN_PM