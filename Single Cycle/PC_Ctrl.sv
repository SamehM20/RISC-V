module PC_Ctrl (
    input logic clk, reset, PC_Src_Ctrl,
                [31:0] PC4, PCjump,
    output logic [31:0] PC
);
    logic [31:0] PCNext;
    assign PCNext = PC_Src_Ctrl? PCjump : PC4;
    always_ff @(posedge clk) begin
        if(!reset) PC <= 0;
        else PC <= PCNext; 
    end
endmodule