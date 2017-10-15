code    SEGMENT
        ASSUME    cs:code
begin:

    mov dl,11001110b   ;enter data
    mov dh,00000000b   ;result
;insert 6th bit    
    mov ah,dl          ;save dh in ah (ah=dh)
    and ah,01000000b   ;select with ah only 6th bit

    mov cl,1           ;set numbers of shift
    shr ah,cl          ;shift left
    or dh,ah           ;add 6th bit on 5th position in dh
    
    mov cl,2
    shr ah,cl
    or dh,ah           ;add 6th bit on 3th pos in dh

    mov cl,3
    shr ah,cl
    or dh,ah           ;add 6th bit on 0th pos in dh

;inserts all bits with dl to need a position in dh 
;insert 7th
    mov ah,dl
    and ah,10000000b

    or dh,ah 

;insert 2th bit
    mov ah,dl
    and ah,00000100b

    mov cl,2
    shl ah,cl
    or dh,ah  

    mov cl,2
    shl ah,cl
    or dh,ah  

;insert 1th bit
    mov ah,dl
    and ah,00000010b
    
    mov cl,1
    shl ah,cl
    or dh,ah

;insert 3th bit
    mov ah,dl
    and ah,00001000b
    
    mov cl,2
    shr ah,cl
    or dh,ah
    nop      ; холоста команда процесора, у даному випадку
        ; використовується для зручності при роботі з налагоджувачем
    MOV AX, 4C00H ; повернення в операційну систему
    INT 21H
code    ENDS
    end     begin