gdt_start:
    dd 0x0
    dd 0x0

; GDT for code segment, base = 0x0, length=0xffff
gdt_code:
    dw 0xffff ; segment length
    dw 0x0    ; segment base
    db 0x0
    db 10011010b ; flags (8 bits)
    db 11001111b ; flags (4 bits) + segment lenght, bits 16-19
    db 0x0 ; segment base, bits 24-31

; GDT for data segment. base and length identical to code segment
; some flags changed
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end- gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start