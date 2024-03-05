module Controller (
    input logic Zero,
                [31:0] Instuction,
    output logic ALU_Src2_Ctrl, PC_Src_Ctrl,
                 Mem_Wr, Reg_Wr,
                 [1:0] Result_Src,
                 [3:0] ALU_op,
                 [31:0] Immediate,
                 [2:0] dWidth_ctrl
);
    logic [6:0] opcode;
    logic [6:0] Funct7;
    logic [2:0] Funct3;
    logic Funct7b5;
    logic Branch;
    logic [2:0] Imm_Ctrl;

    assign opcode = Instuction[6:0];
    assign Funct7 = Instuction[31:25];
    assign Funct3 = Instuction[14:12];
    assign Funct7b5 = Funct7[5];

    Sources_Ctrl sources_ctrl (.Branch, .opcode, .Funct3, .ALU_Src2_Ctrl, .PC_Src_Ctrl, .Mem_Wr, .Reg_Wr, .Result_Src, .Imm_Ctrl, .dWidth_ctrl);
    ALU_Ctrl alu_ctrl (.Funct7b5, .opcode, .Funct3, .ALU_op);
    Branch_Ctrl branch_ctrl (.Zero, .opcode, .Funct3, .Branch);
    Imm_Cal imm_cal (.Instuction, .Imm_Ctrl, .Immediate);
endmodule