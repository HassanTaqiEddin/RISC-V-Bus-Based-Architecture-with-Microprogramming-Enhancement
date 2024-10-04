/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan TaqiEddin     2036057         18                              */
/************************************************************************/
module dataPath ( clock, reset );
	
	/* INPUTS */
	
	// Clock and reset signals 
	input clock, reset;
	// Enable signals for special registers ( IR, A, B, MA)
	wire ldIR, ldA, ldB, ldMA;
	// General enbles for memory and register file  
	wire enReg, enMem;
	// Enables for the buffers to manage writing on the bus
	wire enALU, enImm;
	// Write enable signals for memory and register file
	wire RegWrt, MemWrt;
	// 3 bit selector for register file address mux
	wire [2:0]RegSel;
	// 4 bit selector signal to select the alu operation
	wire [3:0] ALUOp;
	// 2 bit signal so select the desired extended immediate
	wire [1:0] ExSel;
	
	/* OUTPUTS */
	
	// 7 bits opcode
	wire [6:0] Opcode;
	// 1 bit zero and busy signal
	wire zero, busy;
	// function 3 
	wire [2:0] funct3;
	// function 7
	wire [6:0] funct7;
	
	/* WIRES */
	
	// 32 bit Shared Bus
	wire [31:0] sharedBus;
	// 32 bit outputs of registers A and B (inputs to ALU)
	wire [31:0] A_out, B_out;
	// 32 bit output of the IR register (input to immGen)
	wire [31:0] IR_out;
	// 32 bit output of the MA register (input to memory as address)
	wire [31:0] MA_out;
	// 6 bit address , output of the register file  address mux , input to registers file as address 
	wire [5:0] RF_addr;
	// 5 bits register addresses , rs, rt, rd  (inputs to register file  address mux) 
	wire [4:0] rs, rt, rd ;
	// 32 bit outputs and inputs of memory and register file	
	wire [31:0] regFileIO ,memIO;
	// 32 bit outputs of immGen and ALU
	wire [31:0] Immout, aluOut;
	
	/* extracting rs, rt, rd, funct3 and funct7 from IR */
	assign rs = IR_out[19:15];
	assign rt = IR_out[24:20];
	assign rd = IR_out[11:7];
	assign funct3 = IR_out[14:12];
	assign funct7 = IR_out[31:25]; 
	assign Opcode = IR_out[6:0];

	// Instruction Register IR
	register _IR ( .in(sharedBus), .reset(reset), .en(ldIR), .clk(clock), .R(IR_out));
	// Register A
	register _A  ( .in(sharedBus), .reset(reset), .en(ldA),  .clk(clock), .R(A_out));
	// Register B
	register _B  ( .in(sharedBus), .reset(reset), .en(ldB),  .clk(clock), .R(B_out));
	// Memory Address Register
	register _MA ( .in(sharedBus), .reset(reset), .en(ldMA), .clk(clock), .R(MA_out));
	// Inistantiate the Alu 
	ALU alu ( .op1(A_out), .op2(B_out), .ALUOP(ALUOp), .data(aluOut), .zero(zero) );
	// Inistantiate the register file  address mux  
	mux_8x1 mx (.r0({1'b0,rs}) , .r1({1'b0,rt}), .r2({1'b0,rd}), .r3(6'd31), .r4(6'd32), .out(RF_addr), .s(RegSel));
	// Inistantiate the Register File 
	registerFile RF ( .addr(RF_addr), .data(regFileIO), .RegWrt(RegWrt), .enReg(enReg), .clock(clock), .reset(reset));
	// Inistantiate the Memory 
	Memory mem ( .addr(MA_out), .data(memIO), .MemWrt(MemWrt), .enMem(enMem), .clock(clock), .Busy(busy));
	// Inistantiate the Sign Extender
	ImmGen SE (.Data(IR_out), .ImmSel(ExSel), .Immout(Immout) );
	
	// in case of write to register file 
	// if (register file is activated and operation is write ) then: write value of the shared bus to regFileIO
	// else : assign it with Z value to allow register file write on it in case of Read operation from register file
	assign regFileIO = (enReg && RegWrt)? sharedBus:32'bZ;
	// in case of write to memory 
	// if ( memory is activated and operation is write ) then: write value of the shared bus to memIO
	// else : assign it with Z value to allow memory to write on it in case of Read operation from memory
	assign memIO = (enMem && MemWrt)? sharedBus:32'bZ;
	// Shared Bus
	assign sharedBus = (enImm) ? Immout:
					   (enALU) ? aluOut:
					   (enReg && ~RegWrt)? regFileIO:
					   (enMem && ~MemWrt)? memIO:
					    32'bz;
	// Micro Coded Control Unit
	microCodedControlUnit cu(clock, reset, Opcode, zero, busy, funct3, funct7, 
							ldIR, ldA, ldB, ldMA, enReg, enMem, enALU, enImm, RegWrt, MemWrt, RegSel, ALUOp, ExSel);
endmodule





















