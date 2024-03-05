module Imm_Cal (
    input logic [31:0] Instuction,
                [2:0] Imm_Ctrl,
    output logic [31:0] Immediate
);
    always_comb begin
        case (Imm_Ctrl)

            // I-type 
            0: Immediate = $signed(Instuction[31:20]);
            // S-type
            1: Immediate = $signed({Instuction[31:25], Instuction[11:7]}); 
            // B-type
            2: Immediate = $signed({Instuction[31], Instuction[7], Instuction[29:25], Instuction[11:8], 1'b0}); 
            // J-type
            3: Immediate = $signed({Instuction[31], Instuction[19:12], Instuction[20], Instuction[30:21], 1'b0}); 
            // U-type
            4: Immediate = {Instuction[31:12], {12{1'b0}}}; 

            default: Immediate = 32'bx;
        endcase
    end
endmodule