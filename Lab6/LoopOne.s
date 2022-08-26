.text
.global _start
.extern printf

_start:
    ADR   X0, message
    ADR   x20, counter
    LDUR  x21, [x20, #0]
    ADR   x22, n
    LDUR  x23, [x22, #0]
    ADR   x24, i
    LDUR  x25, [x24, #0]
    MOV   X1, X25
    MOV   X2, X21
    B     L1

L1 :
    CMP   X2, 10
    B.NE  L2
    BL    printf
    MOV   X0, #0
    MOV   W8, #93
    SVC   #0

L2 :
    ADD   X2, X2, X23
    ADD   X1, X1, X2
    B     L1


.data
i: .quad 1
n: .quad 1
counter: .quad 1


message: .ascii "%d\n\0"

.end
