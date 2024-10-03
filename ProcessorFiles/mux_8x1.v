/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
module mux_8x1(r0 , r1, r2, r3, r4, r5, r6, r7, out, s);
	
	parameter SEL_WIDTH = 3;
	parameter DATA_WIDTH = 6;
	// Inputs
	input [DATA_WIDTH-1:0]   r0 , r1, r2, r3, r4, r5, r6, r7;
	
	// 6-bit selector line
	input [SEL_WIDTH -1:0] s;	
	
	// Output
	output reg [DATA_WIDTH-1:0] out;

	always @(*)
	case (s)
		
		3'd0: out <= r0;
		3'd1: out <= r1;
		3'd2: out <= r2;
		3'd3: out <= r3;
		3'd4: out <= r4;
		3'd5: out <= r5;
		3'd6: out <= r6;
		3'd7: out <= r7;
		default : out <= 32'bx;

	endcase
endmodule