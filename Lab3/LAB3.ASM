
Node    STRUC
    namex   db      6 dup (?)
    field  dw      0
Node    ENDS

Data1   SEGMENT
    I_struc db ?
    A0      Node    <>
    A1      Node    2 dup (<>)
    A2      Node    4 dup (<>)
    A3      Node    8 dup (<>)
Data1   ENDS

Data2 SEGMENT
B1  Db    'node00','node10','node11','node20','node21','node22','node23' 
B2  Db    'node30','node31','node32','node33','node34','node35','node36','node37'
Data2 ENDS


code1   SEGMENT
assume cs:code1
@begin1:  
    mov ax,Data1
    mov ds,ax
    
    lea bx , A1[0]
    lea dx , A0
    lea si , A3[size A3]
    xor cx,cx
    
 @LOOP1:  
    mov [bx].field,dx
    add bx , type Node
    mov [bx].field,dx
    add dx , type Node
    add bx , type Node
    inc cx
    cmp bx , si
    jl @LOOP1
    jmp far ptr @begin2
    nop
    nop
    nop

code1   ENDS

code2 SEGMENT
assume cs:code2
@begin2 label far
    mov ax , Data1
    mov es , ax
    mov ax , Data2
    mov ds , ax
    
    lea bx , ds:A0
    lea si , es:B1[0]
    lea ax , ds:A3[size A3]
@LOOP2 :
    lea di,[bx].namex
    mov cx,6
    cld
    rep movsb
    add bx,type node
    add di , 12
    cmp bx,ax
    jl @LOOP2
    
    
    nop
    nop
    nop
    
    MOV AX, 4C00H ; повернення в операційну систему
    INT 21H
code2 ENDS
END  @begin1