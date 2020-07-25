print_hex:
    pusha
    mov cx, 0  ; index variable

; Gets last character of dx, which stores data, then convert to ASCII
hex_loop:
    cmp cx, 4  ; loop 4 times for 4 bytes
    je end

    mov ax, dx
    and ax, 0x000f  ; mask first three bytes
    add al, 0x30    ; add 0x30 to convert to ASCII
    cmp al, 0x39    ; if > 9, need to add 8 to represent A-F
    jle step2
    add al, 7

step2:
    ; get correct position to place ASCII char
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx
    mov [bx], al
    ror dx, 4

    add cx, 1
    jmp hex_loop

end:
    mov bx, HEX_OUT
    call print
    popa
    ret

HEX_OUT:
    db '0x0000', 0  ; reserve memory for our new string