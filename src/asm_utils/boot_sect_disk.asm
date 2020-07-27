; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    mov [SECTORS], dh
    mov cl, 0x02   ; sector (0x01, 0x11) 0x01 is our boot sector, 0x02 is the first available sector
    mov ch, 0x00   ; cylinder (0x0 .. 0x3FF)
    ; dl <- drive number. Our caller sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1=floppy2, 0x80=hdd, 0x81=hdd2)
    mov dh, 0x00 ; head number (0x0, 0xF)
    next_group:
        mov di, 5    ; max 5 tries to read
    again:
        mov ah, 0x02
        mov al, [SECTORS]
        ; [es:bx] <- pointer to buffer the data will be stored
        ; caller sets it up for us
        int 0x13
        jc maybe_retry
        sub [SECTORS], al
        jz ready
        mov  cl, 0x01      ;Always sector 1
        xor  dh, 1         ;Next head on diskette!
        jnz  next_group
        inc  ch            ;Next cylinder
        jmp  next_group
    maybe_retry:
        mov ah, 0x00
        int 0x13
        dec di
        jnz again
        jmp disk_error
    ready:
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

DISK_ERROR: db "Disk read err", 0
SECTORS_ERROR: db "Wrong no.sectors read", 0
SECTORS db 0