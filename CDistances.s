.text
.global _start
.extern printf

_start:
    ADR     X0, fmt_str
    ADR     X1, x
    ADR     X2, y
    ADR     X3, N
    LDUR    X3, [X3, 0]
    ADR     X4, z
    LDUR    X4, [X4, 0] 
    ADR     X7, zero
    LDUR    D7, [X7]
    ADR     X8, counterx
    LDUR    X8, [X8, 0]
    LDR     D0, [X1, X8] ///x1
    LDR     D2, [X2, X8] ///y1
    ADD     X4, X4, 1
    LSL     X6, X4, 3
    LDR     D1, [X1, X6] ///x(n)
    LDR     D3, [X2, X6] ///y(n)
    FSUB    D4, D1, D0
    FMUL    D4, D4, D4
    FSUB    D5, D3, D2
    FMUL    D5, D5, D5
    FADD    D12, D4, D5 ///final value of (x2 - x1)^2 + (y2 - y1)^2
    FMOV    D13, D12
    MOV     X12, 1
    MOV     X4, 0
    MOV     X15, 0





Distance:
    ADD     X4, X4, 1
    LSL     X6, X4, 3
    CMP     X4, X3
    B.EQ    EndCond
    LSL     X9, X8, 3
    LDR     D0, [X1, X9] ///x1
    LDR     D2, [X2, X9] ///y1
    LDR     D1, [X1, X6] ///x(n)
    LDR     D3, [X2, X6] ///y(n)
    FSUB    D4, D1, D0
    FMUL    D4, D4, D4
    FSUB    D5, D3, D2
    FMUL    D5, D5, D5
    FADD    D6, D4, D5 ///final value of (x2 - x1)^2 + (y2 - y1)^2
    FCMP    D6, D12
    B.GT    Greater
    B.LT    Less
    
Greater:
    FMOV   D12, D6
    MOV    X14, X8
    MOV    X10, X4
    B      Distance

Less:
    FCMP  D6, D13
    B.LT  Less2
    B     Distance

Less2:
    FMOV  D13, D6
    MOV   X11, X8
    MOV   X12, X4
    B     Distance
    

EndCond:
    ADD X15, X15, 1
    CMP X15, X3
    B.EQ End
    ADD X8, X8, 1
    MOV X4, X15
    B   Distance


End:
    FMOV  D0, D12
    MOV   X1, X14
    MOV   X2, X10
    MOV   X3, X11
    MOV   X4, X12
    BL    printf
    MOV	   X0, #0
	MOV	   X8, #93
	SVC    #0
    
.data

fmt_str: .ascii "Largest distance between indices : %d %d, Smallest distance between indices : %d %d\n\0"

N:
.int 8


x:
.double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505
y:
.double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196


zero:
.double 0.0

counterx:
.quad 0



z:
.int 0


