module PCJump (
    input logic [31:0] PC, Immediate, ALU_Out,
                [6:0] opcode, 
    output logic [31:0] PCjump
);  
    // JALR or Normal Jump/Branch
    assign PCjump = (opcode == 7'b1100111)? PC + ALU_Out : PC + Immediate;
endmodule