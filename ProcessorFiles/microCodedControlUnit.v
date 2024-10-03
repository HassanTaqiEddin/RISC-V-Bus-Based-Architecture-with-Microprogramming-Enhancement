/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan TaqiEddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
module microCodedControlUnit(clock, reset, Opcode, zero, busy, funct3, funct7, 
							ldIR, ldA, ldB, ldMA, enReg, enMem, enALU, enImm, RegWrt, MemWrt, RegSel, ALUOp, ExSel);

	/* INPUTS */
	
	// Clock and reset signals 
	input clock, reset;
	// 7 bits opcode
	input [6:0] Opcode;
	// 1 bit zero and busy signal
	input zero, busy;
	// function 3 
	input [2:0] funct3;
	// function 7
	input [6:0] funct7;
	
	/* OUTPUTS */
	
	// Enable signals for special registers ( IR, A, B, MA)
	output reg ldIR, ldA, ldB, ldMA;
	// General enbles for memory and register file  
	output reg enReg, enMem;
	// Enables for the buffers to manage writing on the bus
	output reg enALU, enImm;
	// Write enable signals for memory and register file
	output reg RegWrt, MemWrt;
	// 3 bit selector for register file address mux
	output reg [2:0]RegSel;
	// 4 bit selector signal to select the alu operation
	output reg [3:0] ALUOp;
	// 2 bit signal so select the desired extended immediate
	output reg [1:0] ExSel;
	
	// next state 
	reg [2:0] nextState;
	
	
	/* Parameters */
	
	// (STATES)next, spin, fetch, dispatch, feqz, fnez;
	parameter Next = 3'd0, Fetch = 3'd1, Dispatch = 3'd2, Spin = 3'd3, FNEZ = 3'd4, FEQZ = 3'd5;
	// for OP_GROUPS (starting address of each instruction microcodes in the Rom )
	parameter ADD = 8'd5, SUB = 8'd8, ADDI = 8'd11, LW = 8'd14, SW = 8'd18, BEQ =8'd22 , J = 8'd28 ;
	// OPCODES
	parameter OP_LW ='d3 , OP_SW = 'd35, OP_J = 111;
	// OPCODES FOR INSTRUCTION TYPES
	parameter OP_R_51 = 'd51, OP_I_19 ='d19 , OP_S_TYPE = 'd35, OP_B_TYPE = 'd99;
	// ALU Operations
	parameter COPY_A  = 4'b0000, COPY_B  = 4'b0001, INC_A_1 = 4'b0010,  
	          DEC_A_1 = 4'b0011, INC_A_4 = 4'b0100, DEC_A_4 = 4'b0101, 
			  _ADD    = 4'b0110, _SUB    = 4'b0111, _AND    = 4'b1000, 
			  _OR     = 4'b1001;
	parameter rs    = 3'd0 , rt    = 3'd1,     rd = 3'd2,     ra = 3'd3   , pc = 3'd4; 
	parameter I_imm = 2'b00, S_imm = 2'b01, B_imm = 2'b10, J_imm = 2'b11  ;


	//ldIR, RegSel[2:0], RegWrt, enReg, ldA, ldB, ALUOp[3:0], enALU, ldMA, MemWrt, enMem, ExSel[1:0], enImm, nextState[2:0] 
	
	// Create the mico codes rom	
	reg [21:0] microCodes [127:0] ;
    
	// current state (Micro Code Program Counter)
	reg [7:0] MPC;
	// OP_GROUPS
	reg [7:0] OP_GROUPS;
	
	// Control ROM address generation
	always @( posedge reset) begin
		
		if (reset)
			MPC <= 0;
		
	end
	
	// Fetch control signals from ROM
	always @(*) begin

		{
		ldIR, RegSel[2:0], RegWrt, enReg, 
		ldA, ldB, ALUOp[3:0],  
		enALU, ldMA, MemWrt, enMem, 		 
		ExSel[1:0], enImm,nextState[2:0] 
		} <= microCodes[MPC];
		
	end

	// OP_GROUPS
	
	always @ (*) begin
	
		case (Opcode)
		
		// R TYPE instructions (opcode = 51)
		
		OP_R_51: begin
			
			 
			case (funct3)
				
				3'd0:begin 
				
					case (funct7) 
						
						// ADD instruction
						'h0: OP_GROUPS <= ADD;
						// SUB instruction
						'h20: OP_GROUPS <= SUB;
					
					endcase
				
				
				// rest of cases can be added if we want to add new instructions
				
				
				end
				
				
			endcase
		
		end
		
		// I TYPE INSTRUCTIONS (opcode = 19)
		
		OP_I_19: begin
		
			case (funct3)
				
				// ADDI instruction
				3'd0: OP_GROUPS <= ADDI;
				// rest of cases can be added if we want to add new instructions
			
			endcase 
		
		
		end
		
		// LW Instruction
		OP_LW: OP_GROUPS <= LW;
		// SW instruction
		OP_SW:  OP_GROUPS <= SW;
		// Branch Type Instructions
		OP_B_TYPE: begin 
			
			case (funct3)
				
				// BEQ instruction
				3'd0: OP_GROUPS <= BEQ;
				// rest of cases can be added if we want to add new instructions
			
			endcase 
			
		end
		// Jump And Link Instruction
		OP_J: 	OP_GROUPS <= J;
	
	
		endcase
	end
	
	// Genegrate Micro Programmed Program counter value  
	always @ (posedge clock) begin
	
		case (nextState) 
		
		
		Fetch: MPC <= 1;
		
		
		Next: MPC <= MPC +1;
		
		Dispatch: MPC <= OP_GROUPS;
		
		
		Spin: MPC <= MPC;
		
		
		FNEZ: MPC <= (zero) ? 1 : MPC + 1;
		
		
		FEQZ: MPC <= (zero) ? MPC + 1 : 1;
		
		
		endcase	
	end
	
	
	//Initialize ROM 
	initial begin
		
		//ldIR, RegSel[2:0], RegWrt, enReg, ldA, ldB, ALUOp[3:0], enALU, ldMA, MemWrt, enMem, ExSel[1:0], enImm, nextState[2:0] 
		// Reset operation 
		microCodes[0] <= {1'b0,3'bx, 1'b0, 1'b0, 1'b0, 1'b0, 4'bx, 1'b0, 1'b0, 1'b0, 1'b0, 2'b0, 1'b0 ,Fetch};
		// Fetch Operation
		//  MA -> PC,  A -> PC
		microCodes[1] <= {1'b0,pc, 1'b0, 1'b1, 1'b1, 1'bx, 4'bx, 1'b0, 1'b1, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// IR -> MEM[MA]
		microCodes[2] <= {1'b1,3'bx, 1'bx, 1'b0, 1'b0, 1'bx, 4'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'bx, 1'b0,Next };
		// PC -> PC(A) + 4
		microCodes[3] <= {1'b0,pc, 1'b1, 1'b1, 1'b0, 1'bx, INC_A_4, 1'b1, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0,Next };

		// Dispatch Operation 
		microCodes[4] <= {1'b0,3'b0, 1'b0, 1'b0, 1'b0, 1'b0, 4'bx, 1'b0, 1'b0, 1'b0, 1'b0, 2'b0, 1'b0 ,Dispatch};
		
		
		// ADD INSTRUCTION
		
		// A ->  REG[RS] 
		microCodes[5] <= {1'b0,rs, 1'b0, 1'b1, 1'b1, 1'bx, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// B ->  REG[RT] 
		microCodes[6] <= {1'b0,rt, 1'b0, 1'b1, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		//REG[RD] ->  A+B 
		microCodes[7] <= {1'b0,rd, 1'b1, 1'b1, 1'b0, 1'b0, _ADD, 1'b1, 1'b0, 1'bx, 1'b0, 2'bx, 1'b0 ,Fetch};
		
		// SUB Instruction
		
		// A ->  REG[RS] 
		microCodes[8] <= {1'b0,rs, 1'b0, 1'b1, 1'b1, 1'bx, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// B ->  REG[RT] 
		microCodes[9] <= {1'b0,rt, 1'b0, 1'b1, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		//REG[RD] ->  A-B 
		
		microCodes[10] <= {1'b0,rd, 1'b1, 1'b1, 1'b0, 1'b0, _SUB, 1'b1, 1'b0, 1'bx, 1'b0, 2'bx, 1'b0 ,Fetch};
		// ADDI Instruction
		
		// A ->  REG[RS] 
		microCodes[11] <= {1'b0,rs, 1'b0, 1'b1, 1'b1, 1'bx, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// B ->  imm 
		microCodes[12] <= {1'b0,3'bx, 1'bx, 1'b0, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, I_imm, 1'b1 ,Next};
		//REG[RD] ->  A+B 
		microCodes[13] <= {1'b0,rd, 1'b1, 1'b1, 1'b0, 1'b0, _ADD, 1'b1, 1'b0, 1'bx, 1'b0, 2'bx, 1'b0 ,Fetch};

		// LW Instruction
		// A ->  imm 
		microCodes[14] <= {1'b0,3'bx, 1'bx, 1'b0, 1'b1, 1'bx, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, I_imm, 1'b1 ,Next};
		// B ->  REG[RS] 
		microCodes[15] <= {1'b0,rs, 1'b0, 1'b1, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// MA ->  A+B
		microCodes[16] <= {1'b0,3'dx, 1'bx, 1'b0, 1'b0, 1'b0, _ADD, 1'b1, 1'b1, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// REG[RT] ->  MEM[MA]
		microCodes[17] <= {1'b0,rd, 1'b1, 1'b1, 1'b0, 1'b0, 4'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'bx, 1'b0 ,Fetch};
		
		// SW Instruction
		// A ->  imm 
		microCodes[18] <= {1'b0,3'bx, 1'bx, 1'b0, 1'b1, 1'bx, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, S_imm, 1'b1 ,Next};
		// B ->  REG[RS] 
		microCodes[19] <= {1'b0,rs, 1'b0, 1'b1, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// MA ->  A+B
		microCodes[20] <= {1'b0,3'dx, 1'bx, 1'b0, 1'b0, 1'b0, _ADD, 1'b1, 1'b1, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// MEM[MA] -> REG[RT] 
		microCodes[21] <= {1'b0,rt, 1'b0, 1'b1, 1'b0, 1'b0, 4'bx, 1'b0, 1'b0, 1'b1, 1'b1, 2'bx, 1'b0 ,Fetch};
		
		// BEQ Instruction
		// A ->  REG[RS] 
		microCodes[22] <= {1'b0,rs, 1'b0, 1'b1, 1'b1, 1'bx, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// B ->  REG[RT] 
		microCodes[23] <= {1'b0,rt, 1'b0, 1'b1, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// A ->  A-B 
		microCodes[24] <= {1'b0,3'dx, 1'bx, 1'b0, 1'b0, 1'b0, _SUB, 1'b1, 1'b0, 1'bx, 1'b0, 2'bx, 1'b0 ,FEQZ};
		// A -> PC
		microCodes[25] <= {1'b0,pc, 1'b0, 1'b1, 1'b1, 1'bx, 4'bx, 1'b0, 1'b0, 1'bx, 1'b0, 2'bx, 1'b0 ,Next};
		// B ->  imm 
		microCodes[26] <= {1'b0,3'bx, 1'bx, 1'b0, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, B_imm, 1'b1 ,Next};
		// PC -> A + B
		microCodes[27] <= {1'b0,pc, 1'b1, 1'b1, 1'b0, 1'b0, _ADD, 1'b1, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0,Fetch };
		
		
		// JUMP AND Link Instruction
		// REG[RD] ->  A
		microCodes[28] <= {1'b0,rd, 1'b1, 1'b1, 1'b0, 1'b0, COPY_A, 1'b1, 1'bX, 1'bX, 1'b0, 2'bx, 1'b0 ,Next};
		// B ->  imm 
		microCodes[29] <= {1'b0,3'bx, 1'bx, 1'b0, 1'b0, 1'b1, 4'bx, 1'b0, 1'bx, 1'bx, 1'b0, J_imm, 1'b1 ,Next};
		// PC -> A + B
		microCodes[30] <= {1'b0,pc, 1'b1, 1'b1, 1'b0, 1'b0, _ADD, 1'b1, 1'bx, 1'bx, 1'b0, 2'bx, 1'b0,Fetch };
		
		
	 
	

	end	


endmodule