module MemData (
    input logic clk, reset, Mem_Wr,
                [31:0] Addr, dataWr,
                [1:0] dataWidth,
    output logic [31:0] dataRd
);
    logic [31:0] MEM_DATA [2048:0];
    logic [31:0] dataRdMid;

    always_comb begin
        dataRdMid = MEM_DATA[Addr[31:2]];
        if(dataWidth == 0)  // Byte
            case (Addr[1:0])
                0: dataRd = dataRdMid[7:0];
                1: dataRd = dataRdMid[15:8];
                2: dataRd = dataRdMid[23:16];
                default: dataRd = dataRdMid[31:24];
            endcase
        else if(dataWidth == 1) // Half-Word
            case (Addr[1])
                0: dataRd = dataRdMid[15:0];
                default: dataRd = dataRdMid[31:16];
            endcase
        else    // Word
            dataRd = dataRdMid;
    end

    always_ff @(posedge clk) begin
        if(!reset) foreach(MEM_DATA[i]) MEM_DATA[i] = 0;
        else if(Mem_Wr) begin
            if(dataWidth == 0)  // Byte
                case (Addr[1:0])
                    0: MEM_DATA[Addr[31:2]][7:0] <= dataWr[7:0];
                    1: MEM_DATA[Addr[31:2]][15:8] <= dataWr[7:0];
                    2: MEM_DATA[Addr[31:2]][23:16] <= dataWr[7:0];
                    default: MEM_DATA[Addr[31:2]][31:24] <= dataWr[7:0];
                endcase
            else if(dataWidth == 1) // Half-Word
                case (Addr[1])
                    0: MEM_DATA[Addr[31:2]][15:0] <= dataWr[15:0];
                    default: MEM_DATA[Addr[31:2]][31:16] <= dataWr[15:0];
                endcase
            else    // Word
                MEM_DATA[Addr[31:2]] <= dataWr;
        end 
    end
endmodule