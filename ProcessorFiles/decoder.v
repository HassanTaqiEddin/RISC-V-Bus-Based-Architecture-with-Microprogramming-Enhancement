/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
module decoder( in, out);
    
	parameter IN_WIDTH = 6;
	// Input 
	input [IN_WIDTH -1:0] in;
	// Output 
	output [IN_WIDTH**2 - 1:0] out;
	
	genvar i;
	generate
		for (i = 0; i < IN_WIDTH**2; i = i + 1) begin : Decoder
			assign out[i] = (in == i);
		end
	endgenerate

endmodule