package defs;
    parameter ALU_NOP  =  4'b1111;    // No ALU Operation
    parameter ALU_ADD  =  4'b0000;
    parameter ALU_SUB  =  4'b1000;
    parameter ALU_SR   =  4'b0101;    // Shift Right Logical
    parameter ALU_SRA  =  4'b1101;    // Shift Right Arithmetic
    parameter ALU_SL   =  4'b0001;    // Shift Left
    parameter ALU_AND  =  4'b0111;
    parameter ALU_OR   =  4'b0110;
    parameter ALU_XOR  =  4'b0100;
    parameter ALU_LTU  =  4'b0011;    // Less Than Unsigned
    parameter ALU_LTS  =  4'b0010;    // Less Than Signed
    parameter ALU_D2   =  4'b1110;    // Pass Input B
endpackage
