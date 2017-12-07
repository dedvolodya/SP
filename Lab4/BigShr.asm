.686 ; можна використовувати .386
.model flat,C ; модель пам`яті та передача параметрів за правилами С
public BigShr ; глобальна видимість процедури, не обов`язково

.code
; void BigShr(byte* p1, int p2)
BigShr proc
; mas - адреса байтового масиву
@mas equ [ebp+8] ; місцезнаходження адреси масиву
; carry
@carry equ [ebp+12] 
@len equ [ebp+16]

push ebp
mov ebp,esp ; базова адреса фактичних параметрів

mov ebx,@mas ; записуємо в ebx адресу масиву
mov ecx,@len
dec ecx
add ebx,ecx ; встановлюємо ebx на старший байт

clc
pushf

;mov eax,@len
xor ecx,ecx

@loop:
	popf
	mov ah,[ebx]
	rcr ah,1
	mov [ebx],ah
	pushf
	dec ebx

	inc ecx
	cmp ecx,@len
	jl @loop

popf
mov ebx,@carry ;записуємо адресу carry в ebx
mov ah,0
jnc @CARRY0
mov ah,1
@CARRY0:


mov [ebx],ah ;записуємо в carry

pop ebp
ret

BigShr endp
end