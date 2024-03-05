module Datapath_Ctrl (
    input logic ALU_Src2_Ctrl,
                [31:0] rdataA, rdataB, Immediate, PC, PC4, dataRd, ALU_Out,
                [1:0] Result_Src,
                [2:0] dWidth_ctrl,
    output logic [31:0] ALU_In1, ALU_In2, Result,
                 [1:0] dataWidth
);
    reg [31:0] memRddata;

    assign ALU_In1 = rdataA;
    // Selecting RS2 / Immediate Value
    assign ALU_In2 = ALU_Src2_Ctrl? Immediate : rdataB;

    // Selecting the Store/Load data width
    assign dataWidth = (dWidth_ctrl[1:0] == 0)? 0:    // Byte
                       (dWidth_ctrl[1:0] == 1)? 1:    // Half-Word
                                                2;    // Word or no Memory opcode
    // Sign-Extending Memory Load Data
    assign memRddata = (dWidth_ctrl == 3'b000)? $signed(dataRd[7:0]):    // LB (Singed)
                       (dWidth_ctrl == 3'b001)? $signed(dataRd[15:0]):   // LH (Singed)
                                                        dataRd;     

    // Selecting the value to be saved in Register RD
    assign Result = (Result_Src == 3)? PC + Immediate:
                    (Result_Src == 2)? PC4:
                    (Result_Src == 1)? memRddata:
                                      ALU_Out;


endmodule