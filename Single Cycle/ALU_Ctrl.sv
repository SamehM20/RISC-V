import defs::*;
module ALU_Ctrl (
    input logic Funct7b5, 
                [6:0] opcode,
                [2:0] Funct3,
    output logic [3:0] ALU_op
);
    always_comb begin
        ALU_op = ALU_NOP;
        // R & I Arithmetic & Logical Operations
        if((opcode==7'b0110011)||(opcode==7'b0010011)) 
            case (Funct3)
                // ADD/I or SUB
                3'b000: if((Funct7b5==1)&&(opcode[5]==1))
                            ALU_op = ALU_SUB;
                        else ALU_op = ALU_ADD; 
                // Shift Left/I
                3'b001: ALU_op = ALU_SL;
                // Set Less Than/I (Signed)
                3'b010: ALU_op = ALU_LTS;
                // Set Less Than/I (Unsigned)
                3'b011: ALU_op = ALU_LTU;
                // XOR/I 
                3'b100: ALU_op = ALU_XOR;
                // Shift Right Logical/I or Shift Right Arithmetic/I
                3'b101: if(Funct7b5==1) ALU_op = ALU_SRA;
                        else ALU_op = ALU_SR;
                // OR/I 
                3'b110: ALU_op = ALU_OR;
                // AND/I 
                3'b111: ALU_op = ALU_AND;
            endcase
        
        // Branching Operations
        else if((opcode==7'b1100011)) 
            case (Funct3)
                // Equal
                3'b000: ALU_op = ALU_XOR;
                // Not Equal
                3'b001: ALU_op = ALU_XOR;
                // Less Than (Signed)
                3'b100: ALU_op = ALU_LTS;
                // Greater Than or Equal (Signed)
                3'b101: ALU_op = ALU_LTS;
                // Less Than (Unsigned)
                3'b110: ALU_op = ALU_LTU;
                // Greater Than or Equal (Unsigned)
                3'b111: ALU_op = ALU_LTU;
            endcase

        // JALR, LOAD & STORE
        else if((opcode==7'b1100111)||(opcode==7'b0000011)||(opcode==7'b0100011))
            ALU_op = ALU_ADD;
        
        // LUI
        else if((opcode==7'b0110111))
            ALU_op = ALU_D2;
    end
endmodule