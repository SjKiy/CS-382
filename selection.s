.extern printf
.global _start
.text

_start:
ADR x0, spaceforS ///Load 5 from space
MOV sp, x0
ADR x0, arr ///Load the array to x0
ADR x1, len ///Load the length of the array
LDR x1, [x1,0]
BL Sort 
ADR x1, len
LDR x1, [x1, 0]
ADR x0, arr
BL print_arr
///end sequence
MOV x0, #0
MOV w8, #93
SVC #0
.func Sort

Sort:
STP x1, x30, [sp, #-16]!
MOV x8, #0 // int i = 0
SUB x17, x1, #1 // length - 1

PartOne:
CMP x8, x17 ///compare i and length - 1 registers
B.GE FirstExit ///if length - 1 register is bigger, end the loop
MOV x12, x8 // min_index = x12 = i
LSL x13, x8, #3 // left shift i
ADD x13, x13, x0 
LDR x13, [x13, 0] // min = array[i] 



PartTwo:
ADD x14, x8, #1 // j = i + 1
CMP x14, x1 /// compare j and length
B.GE SecondExit ///if j is larger or equal to, exit
LSL x15, x14, #3 ///left shift j
ADD x15, x15, x0 ///add to register 15
LDR x15, [x15, 0] // load array[j]
CMP x15, x13 /// if (array[j] < min)
B.GE FirstComparison ///if greater than or equal to just increment j no changes
MOV x12, x14 ////min_index = j
MOV x13, x15 ///min = array[j]

FirstComparison:
ADD x14, x14, #1 // increment j
B PartTwo ///back to the loop

SecondExit:
CMP x12, x8 /// if (min_index != i) ///go to swap
B.EQ SecondComparison ///if equal go to other branch that will add to i and rerun loop

STP x1, x2, [sp, #-16]!
MOV x1, x8
MOV x2, x12
BL swap ///branch to swap

LDP x1, x2, [sp], #16

SecondComparison:
add x8, x8, #1 ///add to i and run again
b PartOne

FirstExit: ///exit
LDP x1, x30, [sp], #16
BR x30
.endfunc

.func swap
swap:
STP x30, x8, [sp, #-16]! ///storing pairs of registers
STP x17, x11, [sp, #-16]!
STP x12, x1, [sp, #-16]!
MOV x8, x1 ///i
LSL x8, x8, #3 ///left shift value
ADD x8, x8, x0
LDR x17, [x8, 0] ///load to x17
MOV x11, x2 /// min index
LSL x11, x11, #3 ///left shift value and add
ADD x11, x11, x0 
LDR x12, [x11, 0] // load to x12
STUR x12, [x8, 0] 
STUR x17, [x11, 0]
LDP x12, x1, [sp], #16 ///load pair registers
LDP x17, x11, [sp], #16
LDP x30, x8, [sp], #16
BR x30

.endfunc

.func print_arr
print_arr:
SUB sp, sp, #16 
STR x1, [sp, 0] 
STR x30, [sp, #8]
MOV x8, #0

print: ///loop to print values
CMP x8, x1 ///x8 iteration compared
B.GE end
STP x0, x8, [sp, #-16]!
SUB sp, sp, #16
STUR x1, [sp, 0]


LSL x11, x8, #3 ///left shift
ADD x12, x0, x11  ///Add left shifted value to register
LDR x12, [x12,0] ///load left shifted value
ADR x0, out  
MOV x1, x12 ///move to x1 print


BL printf
LDR x1, [sp, 0]
ADD sp, sp, #16
ldp x0, x8, [sp], #16
ADD x8, x8, #1 ///increment for comparison
B print

end:


LDUR x1, [sp, 0]
LDUR x30, [sp, #8]
ADD sp, sp, #16
BR LR

.endfunc

.data
out:
.ascii "%d\n\0"
len:
.quad 5
arr:
.quad 9,10,20,11,5
.space 10000
spaceforS:
.space 5
.end


