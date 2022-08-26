.text
.global _start
.extern printf

_start:
    ADR   X0, message
    ADR   x20, one
    LDUR  x21, [x20, #0]
    ADR   x22, two
    LDUR  x23, [x22, #0]
    ADR   x24, three
    LDUR  x25, [x24, #0]
    ADR   x26, four
    LDUR  x27, [x26, #0]
    ADR   x28, five
    LDUR  x29, [x28, #0]
    MOV   x1, x21
    ADD   x1, x1, x23
    ADD   x1, x1, x25
    ADD   x1, x1, x27
    ADD   x1, x1, x29
    MOV   x11, x21
    MOV   x12, x23
    MOV   x13, x25
    ADR   x20, six
    LDUR  x21, [x20, #0]
    ADR   x22, seven
    LDUR  x23, [x22, #0]
    ADR   x24, eight
    LDUR  x25, [x24, #0]
    ADD   x1, x1, x21
    ADD   x1, x1, x23
    ADD   x1, x1, x25
    BL    printf
    MOV   X0, #0
    MOV   W8, #93
    SVC   #0

.data
one: .quad 1
two: .quad 0
three: .quad 4
four: .quad 4
five: .quad 5
six: .quad 3
seven: .quad 9
eight: .quad 5


message: .ascii "%d\n\0"

.end
