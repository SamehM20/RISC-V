module Reg_Int (
    input logic clk, reset, wr,
        [4:0] raddrA, raddrB, waddr,  // Addresses
        [31:0] wdata, // Write Data
    output logic [31:0] rdataA, rdataB  // Read Data 
);
    // Register File
    logic [31:0] reg_file [31:0];

    // Asynchronous Reading Ports
    assign rdataA = (raddrA!=0)? reg_file[raddrA]:0;
    assign rdataB = (raddrB!=0)? reg_file[raddrB]:0;

    // Reset and Synchronous Write
    always_ff @(posedge clk or negedge reset) begin
        if(!reset)  foreach(reg_file[i]) reg_file[i] = 0;
        else if(wr) reg_file[waddr] <= wdata;
    end
endmodule