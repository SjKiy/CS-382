.text
.global _start
.extern printf

_start:
    ADR   X0, message
    ADR   x20, i
    LDUR  x21, [x20, #0]
    ADR   x22, g
    LDUR  x23, [x22, #0]
    ADR   x24, f
    LDUR  x25, [x24, #0]
    ADR   x26, addone
    LDUR  x27, [x26, #0]
    ADR   x28, subtwo
    LDUR  x29, [x28, #0]

    CMP   x21, 4
    B.EQ  L1

    ADD   x2, X23, X29
    MOV   x1, x2
    BL    printf

L1 :

    ADD   x2, X23, X27
    MOV   x1, x2
    BL    printf

    MOV   X0, #0
    MOV   W8, #93
    SVC   #0

.data
i: .quad 4
g: .quad 9
f: .quad 0
addone: .quad 1
subtwo: .quad -2

message: .ascii "f = %d\n\0"

.end
