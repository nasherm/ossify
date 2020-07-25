; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    pusha
    push dx

    mov ah, 0x02   ; set read mode for disk
    mov al, dh     ; number of sectors to read (0x01, 0x80)
    mov cl, 0x02   ; sector (0x01, 0x11) 0x01 is our boot sector, 0x02 is the first available sector
    mov ch, 0x00   ; cylinder (0x0 .. 0x3FF)
    ; dk <- drive number. Oru caller sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1=floppy2, 0x80=hdd, 0x81=hdd2)
    mov dh, 0x00 ; head number (0x0, 0xF)

    ; [es:bx] <- pointer to buffer the data will be stored
    ; caller sets it up for us
    int 0x13
    jc disk_error

    pop dx
    cmp al, dh ; BIOS sets al to number of sectors read
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0