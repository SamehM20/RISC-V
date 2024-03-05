module Sources_Ctrl (
    input logic Branch,
                [6:0] opcode,
                [2:0] Funct3,
    output logic ALU_Src2_Ctrl, PC_Src_Ctrl,
                 Mem_Wr, Reg_Wr,
            [1:0] Result_Src,
            [2:0] Imm_Ctrl,
                  dWidth_ctrl
);

    always_comb begin
        // Memory Write
        case (opcode)
            // S-type
            7'b0100011: Mem_Wr = 1;
            default: Mem_Wr = 0;
        endcase

        // Register Write
        case (opcode)
            // S-type and B-type
            7'b0100011,
            7'b1100011: Reg_Wr = 0;
            default: Reg_Wr = 1;
        endcase

        // Result Source Selection
        case (opcode)
            // AUIPC : Immediate + PC
            7'b0010111: Result_Src = 3;
            // JAL, JALR: PC4, Return Address
            7'b1101111,
            7'b1100111: Result_Src = 2;
            // Load-type: Mem Result
            7'b0000011: Result_Src = 1;
            // R/Imm-types: ALU Result
            default: Result_Src = 0;
        endcase

        // Selecting Next PC (PC4/Branch/Jump)
        case (opcode)
            // JAL, JALR: Jump
            7'b1101111,
            7'b1100111: PC_Src_Ctrl = 1;
            // Branching
            7'b1100011: PC_Src_Ctrl = Branch;
            // PC + 4
            default: PC_Src_Ctrl = 0;
        endcase

        // Selecting ALU Input 2 Source (Register/Immediate)
        case (opcode)
            7'b0000011,
            7'b0100011,
            7'b0010011,
            7'b0110111,
            7'b0010111,
            7'b1101111,
            7'b1100111: ALU_Src2_Ctrl = 1;
            default: ALU_Src2_Ctrl = 0;
        endcase

        // Selecting Immediate Type
        case (opcode)
            // Arithmetic/Logical, Load, and JALR 
            7'b0010011,
            7'b0000011,
            7'b1100111: Imm_Ctrl = 0;
            // Store
            7'b0100011: Imm_Ctrl = 1;
            // Branch
            7'b1100011: Imm_Ctrl = 2;
            // JAL
            7'b1101111: Imm_Ctrl = 3;
            // LUI and AUIPC
            7'b0110111: Imm_Ctrl = 4;

            default: Imm_Ctrl = 0;
        endcase

        // Memory Data Width Control (Load & Store)
        dWidth_ctrl = 3'b111;
        if((opcode==7'b0000011)||(opcode==7'b0100011)) 
            // Bit 2: Signed(0) or Unsigned(1)
            // Bits 1,0: Data Width
            dWidth_ctrl = Funct3;

    end
endmodule