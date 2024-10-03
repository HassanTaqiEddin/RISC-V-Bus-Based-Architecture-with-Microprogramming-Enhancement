/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan TaqiEddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
`timescale 1ns / 1ns
module microCodedControlUnit_tb();

	// /* INPUTS */
	
	// Clock and reset signals 
	reg clock, reset;
	// 7 bits opcode
	reg [6:0] Opcode;
	// 1 bit zero and busy signal
	reg zero, busy;
	// function 3 
	reg [2:0] funct3;
	// function 7
	reg [6:0] funct7;
	
	/* OUTPUTS */
	
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
	
	// Inistantiate the control unit
	microCodedControlUnit cu (clock, reset, Opcode, zero, busy, funct3, funct7, 
							 ldIR, ldA, ldB, ldMA, enReg, enMem, enALU, enImm, RegWrt, MemWrt, RegSel, ALUOp, ExSel);

	// generate clock
	always begin
		#10 clock <= ~clock;
	end
	
	
		/* Parameters */
	
	// (STATES) next, spin, fetch, dispatch, feqz, fnez;
	parameter Next = 3'd0, Fetch = 3'd1, Dispatch = 3'd2, Spin = 3'd3, FNEZ = 3'd4, FEQZ = 3'd5;
	// for OP_GROUPS (starting address of each instruction microcodes in the Rom )
	parameter ADD = 8'd5, SUB = 8'd8, ADDI = 8'd11, LW = 8'd14, SW = 8'd18, BEQ =8'd22 , J = 8'd28 ;
	// OPCODES
	parameter OP_LW ='d3 , OP_SW = 'd35, OP_J = 111;
	// OPCODES FOR INSTRUCTION TYPES
	parameter OP_R_51 = 'd51, OP_I_19 ='d19 , OP_S_TYPE = 'd35, OP_B_TYPE = 'd99;
	
	// initialize clock and reset
	initial begin 
		clock <= 0;
		reset <=1;
		#10 reset <=0;
		
		// ADD Instruction
		Opcode <= OP_R_51;
		funct3 <= 0;
		funct7 <= 0;
		
		#140;
		// LW Instruction
		Opcode <= OP_LW;
		//funct3 <= 0;
		//funct7 <= 0;
		#100 ;
		$stop;
		
	end


endmodule