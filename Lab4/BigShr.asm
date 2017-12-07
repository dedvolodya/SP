.686 ; ����� ��������������� .386
.model flat,C ; ������ ���`�� �� �������� ��������� �� ��������� �
public BigShr ; ��������� �������� ���������, �� ����`������

.code
; void BigShr(byte* p1, int p2)
BigShr proc
; mas - ������ ��������� ������
@mas equ [ebp+8] ; ��������������� ������ ������
; carry
@carry equ [ebp+12] 
@len equ [ebp+16]

push ebp
mov ebp,esp ; ������ ������ ��������� ���������

mov ebx,@mas ; �������� � ebx ������ ������
mov ecx,@len
dec ecx
add ebx,ecx ; ������������ ebx �� ������� ����

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
mov ebx,@carry ;�������� ������ carry � ebx
mov ah,0
jnc @CARRY0
mov ah,1
@CARRY0:


mov [ebx],ah ;�������� � carry

pop ebp
ret

BigShr endp
end