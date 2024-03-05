## RISC V Single Cycle Implementation Using SystemVerilog

The Design implements RV32I except CSR, FENCE, ECALL and EBREAK Instructions.

**The Included Instructions:**
- LUI and AUIPC.
- JAL and JALR.
- Branching Instructions.
- Load Instructions.
- Store Instructions.
- Arithmetic and Logical Instructions (Both R/I Types).

**Testing Codes:**

There are two codes (Code1.txt, Code2.txt) available to test the functionality of the processor.  They represents the machine code in hexadecimal of the following codes:
- Code1.txt:
  
        sw      zero,0(s0)
		.L2:
        lw      a5,0(s0)
        addi    a5,a5,1
        sw      a5,0(s0)
        lw      a4,0(s0)
        lui     a0, 6
        blt     a4,a5,.L2
        nop
        lw      s0,28(sp)
        addi    sp,sp,32
- Code2.txt:
  
		addi x12,x0,255            # initialize x12 with 0x00_00_00_ff
		addi x10,x0,0              # initialize x0  with 0x00_00_00_00
		while:
		addi x10,x10,1
		slli x13,x10,2
		sw x10,0(x13)
		bne  x10,x12,while          # while (x10<=x12) x10 = x10++;
		addi x0,x0,0                #no op

N.B.: Be sure to change the name of the of the program hex file in the instruction memory module and put the code file within the RTL code directory.




# 
### LinkedIn

[Sameh ELbatsh](https://www.linkedin.com/in/sameh-elbatsh)
