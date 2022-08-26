.text
.global _start
.extern printf

_start:
    ADR   X0, message
    ADR   x20, a
    LDUR  x21, [x20, #0]
    ADR   x22, b
    LDUR  x23, [x22, #0]
    ADR   x24, c
    LDUR  x25, [x24, #0]
    ADD   x26, X21, X23
    MOV   x1, x26
    CMP   x1, 14
    B.NE  L1
    MOV   X1, 3
    BL    printf
L1:
    MOV   X1, -2
    BL    printf
    MOV   X0, #0
    MOV   W8, #93
    SVC   #0

.data
a: .quad 5
b: .quad 10
c: .quad 0

message: .ascii "c = %d\n\0"

.end
