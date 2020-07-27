print:
    pusha

start:
    mov al, [bx] ; bx holds the base address of string
    cmp al, 0    ; compare if null byte
    je done

    mov ah, 0x0e ; tty mode for printing
    int 0x10
    
    add bx, 1    ; increment string pointer
    jmp start
    
done: 
    popa
    ret

; print new line
print_nl:
    pusha 

    mov ah, 0x0e
    mov al, 0x0a  ; newline char
    int 0x10
    mov al, 0x0d  ; carriage return
    int 0x10

    popa
    ret