/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
module register ( in, reset, en, clk, R);

	// n -> size of the register
	parameter n = 32;
	
	// Inputs
	input [n-1:0] in;
	input reset, clk, en;
	
	// Outputs
	output reg [n-1:0] R;
	
	always @ ( posedge clk or posedge reset) begin
	
		// Clear the register 
		if (reset) R <= 'b0;
			
		// write on the register if the enable is activated
		else if (en) R <= in;
		
	end
	
endmodule
