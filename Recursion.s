.text
.global _start
.extern printf

_start:
	ADR x24, arr
    MOV x0, #4
    BL  fact
    BL  End

fact:
    SUB SP, SP, #30
    STUR LR, [SP, #8]
    STUR x0, [SP, #0]
    CMP  x0, #1
    B.GT L1
    LDUR x1, [x24, #0]
    ADD  SP, SP, #30
    BR   LR

L1:
    SUB  X0, X0, #1
    BL   fact
    LDUR x0, [SP, #0]
    LDUR LR, [SP, #8]
    ADD  SP, SP, #30
    ADD  X24, X24, #8
    LDUR X2, [X24, 0]
    CMP  X2, X1
    B.GT Greater
    BR LR

Greater:
    MOV x1, x2
    BR  LR

End:
	LDR 	X0, =out
	BL 		printf
    MOV	    X0, #0
	MOV	    X8, #93
	SVC     #0

.data
arr: .dword 3, 9, 11, 4
out: .ascii "max = %d\n\0"




