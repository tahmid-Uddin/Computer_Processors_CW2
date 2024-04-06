// Copy key into RAM[3]
    @R1
    D=M
    @R3
    M=D

// Right Mask = RAM[4]
    @255
    D=A 
    @R4
    M=D

// Left Mask = RAM[5]
    @32640
    D=A
    D=D+A
    @R5
    M=D

// Seperated Right side = RAM[6]
    @R4
    D=M
    @R2
    D=D&M
    @R6
    M=D

// Seperated Left side = RAM[7]
    @R5
    D=M
    @R2
    D=D&M
    @R7
    M=D

// F(right, key) = RAM[8]

// do some random function stuff with i and shit

(END)
    @END
    0;JMP