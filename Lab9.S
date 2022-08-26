.extern printf
.global _start
.text

///a = string
///b = value
_start:
LDR X0, =a
LDR X1, =b
BL  scanf
LDR x1, =b
LDUR x1, [x1,#0]
ADR  X2, arr
ADR  X10, length ///high
LDUR x10, [X10, 0] ///load high
SUB  X11, X10, 1 ///high - 1
MOV  X3, 0 ///Low
MOV X4, 2 ///for division

Compare:
CMP X10, 0
B.EQ NoArray
CMP X3, X11
B.LE Search
MOV  X1, -1
B    end

Search:
ADD  X5, X3, X11 ///Low + High
SDIV X7, X5, X4 ///int mid = (low+high) / 2
MOV  X9, X7
LSL  X7, X7, #3
ADD  X7, X7, X2
LDR  X8, [X7, 0] ///mid
CMP  X8, X1
B.EQ Mid
CMP  X1, X8
B.LT High
B    Low

Low:
ADD  X3, X9, 1 
B    Compare

Mid: ///mid done
Mov X1, X9
B   end

High:
SUB X11, X9, 1 ///High = mid-1
B Compare


NoArray:
LDR x0, =outNoArray
BL  printf
MOV X0, #0
MOV W8, #93
SVC #0


end:
CMP X1, -1
B.NE EndGood
B EndBad

EndGood:
LDR x0, =out
BL  printf
MOV X0, #0
MOV W8, #93
SVC #0

EndBad:
LDR x0, =outbad
BL  printf
MOV X0, #0
MOV W8, #93
SVC #0

.data

out:
.ascii "Query found: index = %d\n\0"

outbad:
.ascii "The query is not in the array\n\0"

outNoArray:
.ascii "No Array Listed\n\0"


arr:
.dword 5,10,15,20,25,30,35,40 ///Change

length:
.quad 8 ///Change




.space 10000
a:
.string "%d"

b:
.dword 0

spaceforS:
.space 9
.end


