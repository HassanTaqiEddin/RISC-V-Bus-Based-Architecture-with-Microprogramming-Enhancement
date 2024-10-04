/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan TaqiEddin     2036057         18                              */
/************************************************************************/

`timescale 1ns / 1ns
//This module created to test the Alu unit

module ALU_tb();

	//Ports Of the the module being tested:
	
	// All inputs are defined as registers
	//Inputs:
	reg [31:0] op1, op2;
	reg [3:0]  ALUOP;
	
	// All outputs are defined as wires
	//Outputs:
	wire [31:0] data;
	wire zero;

	// Instantiate ALU Module
	ALU dut(op1,op2,ALUOP,data,zero);
	
	
	initial begin
	
		// Testing COPY_A operation	
		ALUOP <= 4'b0000;
		op1 <= 32'hffffffff;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0xffffffff , zero = 0

		#10
		// Checking zero flag
		ALUOP <= 4'b0000;
		op1 <= 32'h00000000;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		#10
		// Testing COPY_B operation	
		ALUOP <= 4'b0001;
		op1 <= 32'hffffffff;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =h0000ffff , zero = 0

		#10
		// Checking zero flag
		ALUOP <= 4'b0001;
		op1 <= 32'h0000ffff;
		op2 <= 32'h00000000;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		
		// Testing INC_A_1 operation	
		#10
		ALUOP <= 4'b0010;
		op1 <= 32'h00000000;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000001 , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b0010;
		op1 <= 32'hffffffff;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		
		// Testing DEC_A_1 operation	
		#10
		ALUOP <= 4'b0011;
		op1 <= 32'h00000002;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000001 , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b0011;
		op1 <= 32'h00000001;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		
		// Testing INC_A_4 operation	
		#10
		ALUOP <= 4'b0100;
		op1 <= 32'h00000000;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000004 , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b0100;
		op1 <= 32'hfffffffc;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000000 , zero = 1
	
	
	
		// Testing DEC_A_4 operation	
		#10
		ALUOP <= 4'b0101;
		op1 <= 32'h00000000;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0xfffffffc , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b0101;
		op1 <= 32'h00000004;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
	
		// Testing ADD operation	
		#10
		ALUOP <= 4'b0110;
		op1 <= 32'hffff0000;
		op2 <= 32'h0000ffff;
		// Expected output: 
		// data =0xffffffff , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b0110;
		op1 <= 32'h00000004;
		op2 <= 32'hfffffffc;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		
		// Testing SUB operation	
		#10
		ALUOP <= 4'b0111;
		op1 <= 32'hfffffffc;
		op2 <= 32'h0000000c;
		// Expected output: 
		// data =0xfffffff0 , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b0111;
		op1 <= 32'hfffffffc;
		op2 <= 32'hfffffffc;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		// Testing AND operation	
		#10
		ALUOP <= 4'b1000;
		op1 <= 32'hfffffffc;
		op2 <= 32'hf000000c;
		// Expected output: 
		// data =0xf000000c , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b1000;
		op1 <= 32'hfffffffc;
		op2 <= 32'h00000000;
		// Expected output: 
		// data =0x00000000 , zero = 1
		
		
		// Testing OR operation	
		#10
		ALUOP <= 4'b1001;
		op1 <= 32'hfffffffc;
		op2 <= 32'hf000000c;
		// Expected output: 
		// data =0xfffffffc , zero = 0
		#10
		// Checking zero flag
		ALUOP <= 4'b1001;
		op1 <= 32'h00000000;
		op2 <= 32'h00000000;
		// Expected output: 
		// data =0x00000000 , zero = 1		
		
		
		
		
		
		
		
		#10
		
		//stop simulation
		$stop;
	
	end
endmodule
