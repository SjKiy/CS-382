.text
.global _start
.extern printf

_start:
    ADR     X0, fmt_str
    ADR     X1, a
    LDUR    D0, [X1]
    ADR     X1, b
    LDUR    D1, [X1]
    ADR     X1, n
    LDUR    D2, [X1]
    ADR     X1, Coeff1
    LDUR    D3, [X1]
    ADR     X1, Coeff2
    LDUR    D4, [X1]
    ADR     X1, Coeff3
    LDUR    D5, [X1]
    ADR     X1, Coeff4
    LDUR    D6, [X1]
    ADR     X1, one
    LDUR    D7, [X1]
    ADR     X1, zero
    LDUR    D8, [X1]
    ADR     x1, Value
    LDUR    D19, [X1]
    FSUB    D9, D0, D1 
    FDIV    D10, D9, D2 
    

Loop:
    FADD    D1, D10, D1 ////D1 is value of value between limit (x)
    FMUL    D11, D1, D1 ///D2 is (x^2)
    FMUL    D12, D11, D1 ///D3 is (x^3)
    FMUL    D13, D3, D12 ///first value
    FMUL    D14, D4, D11 ///second value
    FMUL    D15, D5, D1 ///third value
    FADD    D13, D13, D14
    FADD    D13, D13, D15
    FADD    D13, D13, D6
    FADD    D20, D20, D13
    FSUB    D2, D2, D7
    FCMP    D2, D8
    B.EQ    End
    B       Loop


End:
    FMUL   D20, D20, D10
    FMOV   D0, D20
    FSUB   D18, D20, D19
    FMOV   D1, D19
    FMOV   D2, D18

    BL     printf
    MOV	   X0, #0
	MOV	   X8, #93
	SVC    #0
        

.data
fmt_str: .ascii "Approximation : %f
Actual : %f
Difference : %f\n\0"


a: .double 5.0
b: .double -0.5
n: .double 500000.0

one: .double 1.0
zero: .double 0.0

Value: .double 74.1069775


Coeff1: .double 2.5
Coeff2: .double -15.5
Coeff3: .double 20.0
Coeff4: .double 15.0
.bss
result: .skip 8





