// Copy key into RAM[3]
    @R1
    D=M
    @R3
    M=D

// Separate right side using mask = RAM[6]
    @255
    D=A 
    @R2
    D=D&M
    @R6
    M=D

// Separate Left side using mask = RAM[7]
    @32640
    D=A
    D=D+A
    @R2
    D=D&M
    @R7
    M=D

// Rotates RAM[7] (left) so that its on the right side
    @R7 
    D=M 
    @R12 //input
    M=D

    @32767
    D=A
    @R13 //mask for 16 bit rotation
    D=!D 
    M=D

    @8
    D=A 
    @R15 //number of rotations
    M=D

    @R10 //counter to know where to exit
    M=0

    @ROTATE 
    0;JMP
(C3)
    @R12 //rotate output
    D=M 
    @R7 
    M=D 

// Loops RAM[4] (4) times
    @R5 //loop counter
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
    @LOOPEND
    D;JGT

// F(right, key) = RAM[8]
    // RAM[11] = NOT key (RAM[3])
    @R3
    D=M 
    @R11
    M=!D

    // RAM[12] = Right (RAM[6])
    @R6
    D=M 
    @R12
    M=D

    // RAM[10] = 0 (counter for selecting exit point)
    @R10
    M=0

    // RAM[15] = R XOR NOT K 
    @XOR
    0;JMP
(C1)
    // Separates right side of XOR output
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

// Iteration Result = left side = RAM[7]
    // RAM[15] = RAM[7] XOR RAM[8]
    // RAM[11] = RAM[7]
    @R7
    D=M
    @R11
    M=D 

    // RAM[12] = RAM[8]
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
    // Seperated Right side = RAM[7]
    @255
    D=A 
    @R7
    D=D&M
    M=D

// Swap left and right
    // RAM[9] (temp) = RAM[7] (left)
    @R7
    D=M
    @R9
    M=D

    // RAM[7] = RAM[6]
    @R6
    D=M 
    @R7 
    M=D 

    // RAM[6] = RAM[9] (= RAM[7])
    @R9
    D=M
    @R6 
    M=D

// Rotates key
    @R3 
    D=M 
    @R12 // input for rotate func
    M=D

    @128 
    D=A 
    @R13 // mask for 8 bit rotation
    M=D 

    @R10 // counter for exit point
    M=1

    @R15 // number of rotations
    M=1

    @ROTATE 
    0;JMP
(C4)
    // Updates key copy - RAM[3]
    @R12
    D=M 
    @R3 
    M=D 

    // Increments i
    @R5
    M=M+1
    @LOOP
    0;JMP
(LOOPEND)

// MERGE LEFT AND RIGHT
    // Shifts the left 8 bits to the left 8 times
    // Repeated adding faster than rotation func and using loop
    @R7
    D=M
    D=D+M
    M=D
    D=D+M
    M=D
    D=D+M
    M=D
    D=D+M
    M=D
    D=D+M
    M=D
    D=D+M
    M=D
    D=D+M
    M=D
    D=D+M
    M=D

    // RAM[0] = RAM[7] OR RAM[6]
    @R6
    D=D|M
    @R0 
    M=D

(END)
    // Program end
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
    D;JNE
    @C3
    0;JMP

(FIRSTROTATE)
    @C4
    0;JMP
(ROTATEEND)