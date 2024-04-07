// Copy key into RAM[3]
    @R1
    D=M
    @R3
    M=D

// Seperated Right side = RAM[6]
    @255
    D=A 
    @R2
    D=D&M
    @R6
    M=D

// Seperated Left side = RAM[7]
    @32640
    D=A
    D=D+A
    @R2
    D=D&M
    @R7
    M=D

// Loops RAM[4] times
    @R5
    M=1
    @4
    D=A 
    @R4 
    M=D 

(LOOP)
// Breaks out of loop when RAM[5] > RAM[4]
    @R5
    D=M
    @R4
    D=D-M
    @END
    D;JGT

// RAM[10] - counter to know where to return after jump
//           0 for C1, 1 for C2.
// F(right, key) = RAM[8]
    // RAM[11] = NOT key (RAM[3])
    @R3
    D=M 
    @R11
    M=!D

    // RAM[12] = right (RAM[6])
    @R6
    D=M 
    @R12
    M=D

    // RAM[10] = 0
    @R10
    M=0

    // RAM[15] = R XOR NOT K 
    @XOR
    0;JMP
(C1)
    // Seperated Right side = RAM[15]
    @255
    D=A 
    @R15
    D=D&M
    M=D

    // RAM[8] = RAM[15]
    @R15 
    D=M
    @R8
    M=D

// Iteration Results = left side = RAM[7]
    // RAM[8] left shift 8 times
    @R8
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D

    // RAM[15] = RAM[7] XOR RAM[8]
    @R7
    D=M
    @R11
    M=D 

    @R8
    D=M 
    @R12 
    M=D 

    @XOR
    0;JMP
(C2)

    // RAM[7] = RAM[15]
    @R15
    D=M
    @R7
    M=D

// Swap left and right
    // RAM[9] (temp) = RAM[7] (left)
    @R7
    D=M
    @R9
    M=D

    @R6
    D=M 
    @R7 
    M=D 

    @R9
    D=M
    @R6 
    M=D

// Rotate key
    @R3 
    D=M 
    @R12 
    M=D

    @128 
    D=A 
    @R13 
    M=D 

    @R15
    M=1

    @ROTATE 
    0;JMP
(C3)
    // Seperated Right side = RAM[6]
    @255
    D=A 
    @R12
    D=D&M
    M=D

    @R12
    D=M 
    @R3 
    M=D 

// Rotate RAM[6], so that its on the right
    @R6 
    D=M 
    @R12 
    M=D

    @32767
    D=A
    @R13 
    D=!D 
    M=D

    @8
    D=A 
    @R15
    M=D

    @R10
    M=0

    @ROTATE 
    0;JMP
(C4)
    @R12
    D=M 
    @R6 
    M=D 

// Shift RAM[7] so its on the left
    @R7
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    D=M
    D=D+M
    M=D
    

// Merges left and right
    @R6
    D=M
    @R7 
    D=D|M 
    @R0 
    M=D

    // Increments i
    @R5
    M=M+1
    @LOOP
    0;JMP

(END)
    
    @END
    0;JMP



// RAM[15] = RAM[12] XOR RAM[11]
(XOR)
    @R11
    D=M
    @R13
    M=!D

    @R12
    D=M
    @R14
    M=!D

    @R12
    D=M
    @R13
    D=M&D
    M=D

    @R11
    D=M
    @R14
    D=M&D
    M=D

    @R13
    D=M
    @R14
    D=M|D
    @R15
    M=D

    // Selects where to jump
    @R10
    D=M
    @FIRSTXOR
    D;JEQ
    @C2
    0;JMP

(FIRSTXOR)
    @R10 
    M=1
    @C1
    0;JMP

(XOREND)


(ROTATE)
// Loops RAM[15] times
    @i
    M=1
// Sets RAM[11] to 0 - represents leading 1 counter
    @R11
    M=0

(LOOPTWO)
// Breaks out of loop when i > RAM[15]
    @i
    D=M
    @R15
    D=D-M
    @LOOPTWOEND
    D;JGT

// RAM[14] = Mask (RAM[13]) AND RAM[12]
    @R12
    D=M
    @R13
    D=D&M
    @R14
    M=D

// Updates leading 1 counter based on whether RAM[14] > 0
    @FUNC
    D;JNE
    @R11
    M=0
    @FUNCEND
    0;JMP
(FUNC)
    @R11
    M=1
(FUNCEND)

// Adds number to itself
    @R12
    D=M
    D=D+M
    M=D

// Adds leading 1
    @R12
    D=M
    @R11
    D=D+M
    @R12
    M=D

// Increments i
    @i
    M=M+1
    @LOOPTWO
    0;JMP
(LOOPTWOEND)

// Selects where to jump
    @R10
    D=M
    @FIRSTROTATE
    D;JEQ
    @C3
    0;JMP

(FIRSTROTATE)
    @R10
    M=1
    @C4
    0;JMP
(ROTATEEND)