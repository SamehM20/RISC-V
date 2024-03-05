module PC4 (
    input logic [31:0] PC,
    output logic [31:0] PC4
);
    assign PC4 = PC + 4;
endmodule