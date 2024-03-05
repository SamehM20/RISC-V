/*
||||||||||||||||||||||||||||||||||||||||||||
||||||||||||||||||||||||||||||||||||||||||||
||||||/ ___|  / \  |  \/  | ____| | | ||||||  
||||||\___ \ / _ \ | |\/| |  _| | |_| ||||||  
|||||| ___) / ___ \| |  | | |___|  _  ||||||  
|||||||____/_/ __\_\_| _|_|_____|_|_|_||||||  
|| ____| |   | __ )  / \|_   _/ ___|| | | || 
||  _| | |   |  _ \ / _ \ | | \___ \| |_| || 
|| |___| |___| |_) / ___ \| |  ___) |  _  || 
||_____|_____|____/_/   \_\_| |____/|_| |_|| 
||||||||||||||||||||||||||||||||||||||||||||
||||||||||||||||||||||||||||||||||||||||||||
RISC V Single Cycle V1 Implementation Using SystemVerilog.
The Design implements RV32I except CSR, FENCE, ECALL and EBREAK Instructions.
The Included Instructions:
- LUI and AUIPC.
- JAL and JALR.
- Branching Instructions. 
- Load Instructions.
- Store Instructions.
- Arithmetic and Logical Instructions (Both R/I Types).
The System has an Active Low Reset that resets Registers (Data and PC) and Data Memory.
*/
module RISCV (
    input clk, reset
);
    logic [31:0] Instuction, ALU_In1, ALU_In2,
          ALU_Out, Result, dataRd, rdataA, rdataB,
          Immediate, PC, PC4, PCjump;
    logic [6:0] opcode;

    logic [3:0] ALU_op;
    logic Zero, Mem_Wr, Reg_Wr, ALU_Src2_Ctrl, PC_Src_Ctrl;
    logic [1:0] Result_Src, dataWidth;

    logic [4:0] raddrA, raddrB, waddr;
    logic [2:0] dWidth_ctrl;

    assign opcode = Instuction[6:0];
    assign raddrA = Instuction[19:15];
    assign raddrB = Instuction[24:20];
    assign waddr  = Instuction[11:7];

    Controller ctrl (.Zero, .Instuction, .ALU_Src2_Ctrl, .PC_Src_Ctrl, .Mem_Wr, .Reg_Wr, .Result_Src, .ALU_op, .Immediate, .dWidth_ctrl);
    Datapath_Ctrl datapath (.ALU_Src2_Ctrl, .rdataA, .rdataB, .Immediate, .PC, .PC4, .dataRd, .ALU_Out, .Result_Src, .dWidth_ctrl, .ALU_In1, .ALU_In2, .Result, .dataWidth);
    ALU alu (.ALU_op, .ALU_In1, .ALU_In2, .Zero, .ALU_Out);
    PC4 pc4 (.PC, .PC4);
    PCJump pcj (.PC, .Immediate, .ALU_Out, .opcode, .PCjump);
    PC_Ctrl pcctrl (.clk, .reset, .PC_Src_Ctrl, .PC4, .PCjump, .PC);

    Reg_Int regfile (.clk, .reset, .wr(Reg_Wr), .raddrA, .raddrB, .waddr, .wdata(Result), .rdataA, .rdataB);
    MemData datamem (.clk, .reset, .Mem_Wr, .Addr(ALU_Out), .dataWr(rdataB), .dataWidth, .dataRd);
    MemInst instmem (.addr(PC), .Instuction);
endmodule