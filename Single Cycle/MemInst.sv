module MemInst (
    input logic [31:0] addr,
    output logic [31:0] Instuction
);
    logic [31:0] MEM_INST [2048:0];
    initial $readmemh("Code.txt", MEM_INST);

    assign Instuction = MEM_INST[addr[31:2]];
endmodule