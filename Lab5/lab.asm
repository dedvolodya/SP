.386
data segment use16
;flags
	left db 0
	right db 0
data ends

assume cs:code
code segment use16

;fill up part of screen black color
cleanup proc
	mov di,0        ;position on begin of screen
	mov cx,1000d
	mov	ax, 0000h
	rep 	stosw
	ret
cleanup endp

;fill down part of screen black color
cleandown proc
	mov di,2000d    ;position on midle of screen
	mov cx,1000d    ;counter for repeat
	mov	ax, 0000h
	rep 	stosw
	ret
cleandown endp

;fill top of screen by text
writeup proc
	mov di,0        ;position on begin of screen
	xor ax,ax
	mov cx,1000d
	mov bx,200
	loop1:
	 	stosw
		mov ax,es:[bx]
		inc bx
	loop loop1
	xor ax,ax
	ret
writeup endp 

;fill down part of screen by text
writedown proc
	mov di,2000d        ;position on begin of screen
	xor ax,ax
	mov cx,1000d
	mov bx,0
	loop2:
 		stosw
		mov ax,ds:[bx]
		inc bx
	loop loop2
	xor ax,ax
	ret
writedown endp 

;processing mouse clicks
mouse proc far
	;save registers
	push ds
	push es
	pusha
	push 0b800h
	pop es
	push data
	pop ds

	mov ax,bx       ;register bx contain in first bit flag left mouse click
	and ax,0000001b ;pick first bit
	cmp ax,0000001b
	jne no_left_click  ;if no left botton , that's right botton
	cmp left,0         
	je clean1           ;if top of screen is full of text 
	call writeup		;if top of screen is empty
	mov left,0h  
	jmp exit           ;exit from proc
clean1:
	call cleanup
	mov left,1h
	jmp exit
no_left_click:             ;the same to left click
	cmp right,0        ;but with bottom of screen
	je clean2
	call writedown
	mov right,0h
	jmp exit
clean2:
	call cleandown
	mov right,1h
exit:
	popa
	pop es
	pop ds
        retf                     ; exit from proc

mouse endp
;begin of programm
start:
	mov ax,data
	mov ds,ax

	mov     ax,0003h
        int     10h           ; video mode 3
	push 0b800h
	pop es
	call writeup
	call writedown
	mov         ax,0         ; initialization mouse
        int         33h
        mov         ax,1         ; show cursor
        int         33h
        mov         ax,000Ch     ; make mouse event processor
        mov         cx,0001010b     ; event - press left or right botton
	push cs
	pop es
        mov         dx,offset mouse ; ES:DX - adress of processor
        int         33h

	;waiting for press any key
	mov ah,01h
	int 21h
	
	xor 		cx,cx		;cx=0
	mov		ax,0ch	        ;disable mouse processor
	int 33h

	mov        ax,4C00h
        int        21h               ; return to operation system
code ends
end start
