# ABI & Calling Conventions


This project demonstrates a correct implementation of a C function
in x86-64 assembly, respecting the System V ABI.


## Calc function in C :

```c
long calc(long a, long b, long c, long d, long e, long f, long g) {

    return (a + b*2) - (c + d*3) + (e*4 - f) + g;

}
```

### Function logic :

We can structure this opération : `(a + b*2) - (c + d*3) + (e*4 - f) + g;`

By doing : 
- t1 = (b*2) + a
- t2 = (d*3) + c
- t3 = (e*4) - f
- r = t1 - t2 + t3 + g

## Argument mapping (SysV x64)

| Argument | Location |
|--------|----------|
| a | RDI |
| b | RSI |
| c | RDX |
| d | RCX |
| e | R8 |
| f | R9 |
| g | [rsp + 8] |

## Stack layout

At function entry:

rsp -> return address
rsp+8 -> 7th argument (g)

## Register usage

- rax: return value
- r10: temporary (caller-saved)
- no callee-saved registers modified

Caller-saved registers are used for temporary values, so no register
needs to be preserved by the callee.


## Calc function in ASM :

```asm
calc:
	lea rax, [rdi + rsi*2] ; RAX = A + B*2

	lea r10, [rdx + rcx*3] ; RCX = C + D*3

	sub rax, r10 ; RAX - RCX | that is t1 - t2

	lea rcx, [r8*4] ; RCX = E*4
	sub rcx, r9 ; RCX -= F

	add rax, rcx ; RAX + RCX that is (t1-t2) + t3

	mov rdx, [rsp + 8] ; get g argument
	add rax, rdx ; add g to rax

	
    ret
```

LEA is used instead of IMUL to perform constant multiplications
without modifying CPU flags.

The function does not perform any call, so stack alignment is preserved.
