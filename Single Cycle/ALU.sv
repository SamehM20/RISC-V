import defs::*;
module ALU (
    input logic [3:0] ALU_op,
        [31:0] ALU_In1, ALU_In2,
    output logic Zero,
                 [31:0] ALU_Out
);
    logic [31:0] sub;
    assign sub = ALU_In1 - ALU_In2;
    assign Zero = ~|(ALU_Out);

    always_comb begin
        case (ALU_op)
            // Addition
            ALU_ADD: ALU_Out = ALU_In1 + ALU_In2;
            // Subtraction
            ALU_SUB: ALU_Out = sub;

            // Right Shift 
            ALU_SR:  ALU_Out = ALU_In1 >> ALU_In2[4:0];
            // Right Shift Arithmetic
            ALU_SRA: ALU_Out = ALU_In1 >>> ALU_In2[4:0];
            // Left Shift 
            ALU_SL:  ALU_Out = ALU_In1 << ALU_In2[4:0];

            // ANDing
            ALU_AND: ALU_Out = ALU_In1 & ALU_In2;
            // ORing
            ALU_OR:  ALU_Out = ALU_In1 | ALU_In2;
            // XORing
            ALU_XOR: ALU_Out = ALU_In1 ^ ALU_In2;

            // Less Than (unsigned)
            ALU_LTU: if(ALU_In1 < ALU_In2) ALU_Out = 1;
                     else ALU_Out = 0;
            // Signed Less Than 
            ALU_LTS: if(ALU_In1[31] != ALU_In2[31])
                        if(ALU_In1[31]) ALU_Out = 1;
                        else ALU_Out = 0;
                     else 
                        if(sub[31]) ALU_Out = 1;
                        else ALU_Out = 0;
            // Pass Second Input
            ALU_D2: ALU_Out = ALU_In2;
            default: ALU_Out = ALU_In1;
        endcase
    end
endmodule