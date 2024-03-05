module Branch_Ctrl (
    input logic Zero,
                [6:0] opcode,
                [2:0] Funct3,
    output logic Branch
);

always_comb
        // Branching Operations
        if(opcode==7'b1100011) 
            case (Funct3)
                // Equal
                3'b000: Branch = Zero;
                // Not Equal
                3'b001: Branch = ~Zero;
                // Less Than (Signed)
                3'b100: Branch = ~Zero;
                // Greater Than or Equal (Signed)
                3'b101: Branch = Zero;
                // Less Than (Unsigned)
                3'b110: Branch = ~Zero;
                // Greater Than or Equal (Unsigned)
                3'b111: Branch = Zero;
                
                default: Branch = 0;
            endcase
endmodule