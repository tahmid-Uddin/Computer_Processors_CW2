// Sets RAM[6] 0 - represents leading 1 counter
    @0
    D=A
    @R6
    M=D

// Mask (1[15]0) = RAM[7]
    @32767
    D=D+A
    D=D+1
    @R7
    M=D

// Copies input to RAM[5]
    @R3
    D=M
    @R5
    M=D

// Loops RAM[4] times
    @i
    M=1
(LOOP)
// Breaks out of loop when i > RAM[4]
    @i
    D=M
    @R4
    D=D-M
    @END
    D;JGT
    
// RAM[8] = Mask AND RAM[5]
    @R5
    D=M
    @R7
    D=D&M
    @R8
    M=D

// Updates leading 1 counter
    @FUNC
    D;JGE
    @R6
    M=1
    @FUNCEND
    0;JMP
(FUNC)
    @R6
    M=0
(FUNCEND)

// Adds number to itself
    @R5
    D=M
    D=D+M
    M=D

// Adds leading 1
    @R5
    D=M
    @R6
    D=D+M
    @R5
    M=D

// Increments i
    @i
    M=M+1
    @LOOP
    0;JMP
(END)
    @END
    0;JMP