global calc
section .text
calc:
	lea rax, [rdi + rsi*2] ; RAX = A + B*2

	lea r10, [rdx + rcx*3] ; RCX = C + D*3

	sub rax, r10 ; RAX - RCX soit t1 - t2

	lea rcx, [r8*4] ; RCX = E*4
	sub rcx, r9 ; RCX -= F

	add rax, rcx ; RAX + RCX soit (t1-t2) + t3

	mov rdx, [rsp + 8] ; récupérer g 
	add rax, rdx ; l'ajouter a la fin soit rax + g

	
    ret


; (a + b*2) - (c + d*3) + (e*4 - f) + g;
; donc d'abord :
;		- t1 = (b*2) + a
;		- t2 = (d*3) + c
;		- t3 = (e*4) - f
;		- r = t1 - t2 + t3 + g
;
;
;
; - a = RDI
; - b = RSI
; - c = RDX
; - d = RCX
; - e = R8
; - f = R9
;
;
;
;