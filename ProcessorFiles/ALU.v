/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan TaqiEddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/

// This module is combinational circuit which performs arithmatic and logical operations
module ALU ( op1,op2, ALUOP, data, zero );

	// Two operands 
	input [31:0] op1,op2;

	// ALU operations (10 operations can be represnted using 4 bits)
	input [3:0] ALUOP;

	// ALU result 
	output reg [31:0] data;

	// Zero Flag 
	output reg zero;
	
	// signed register used in some cases 
	reg signed [31:0] signedreg1,signedreg2;
	
	// Operations
	parameter COPY_A  = 4'b0000, COPY_B  = 4'b0001, INC_A_1 = 4'b0010,  
	          DEC_A_1 = 4'b0011, INC_A_4 = 4'b0100, DEC_A_4 = 4'b0101, 
			  ADD     = 4'b0110, SUB     = 4'b0111, AND     = 4'b1000, 
			  OR      = 4'b1001;

			  


	always @(*) begin
	
		// Perfrom operations based on the ALUOP
		case(ALUOP)
		
			//COPY_A
			COPY_A: begin
			data<= op1;
			zero <= (data == 32'b0);
			end
			
			//COPY_B
			COPY_B: begin
			data<= op2;
			zero <= (data == 32'b0);
			end
			
			// INC_A_1
			INC_A_1: begin
			data <= op1 + 1;
			zero <= (data == 32'b0);
			end
			
			// DEC_A_1
			DEC_A_1: begin
			data <= op1 - 1;
			zero <= (data == 32'b0);
			end
			
			// INC_A_4
			INC_A_4: begin
			data <= op1 + 4;
			zero <= (data == 32'b0);
			end
			
			// DEC_A_4
			DEC_A_4: begin
			data <= op1 - 4;
			zero <= (data == 32'b0);
			end
			
			// ADD
			ADD: begin
			data <= op1+op2;
			zero <= (data == 32'b0);
			end
			
			// SUB
			SUB: begin
			data <= op1 - op2;
			zero <= (data == 32'b0);
			end
			
			// AND
			AND: begin
			data <= op1 & op2;
			zero <= (data == 32'b0);
			end
			
			// OR
			OR: begin
			data <= op1 | op2;
			zero <= (data == 32'b0);
			end
			
			// default case
			default: begin
			data <= 32'bx;
			zero <= 1'bx;
			
			end
		endcase
	end
endmodule