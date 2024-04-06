// RAM[5] = RAM[3] XOR RAM[4]

    @R3
    D=M
    @R6
    M=!D

    @R4
    D=M
    @R7
    M=!D

    @R3
    D=M
    @R7
    D=M&D
    @R8
    M=D

    @R4
    D=M
    @R6
    D=M&D
    @R9
    M=D

    @R8
    D=M
    @R9
    D=M|D
    @R5
    M=D
(END)
    @END
    0;JMP










