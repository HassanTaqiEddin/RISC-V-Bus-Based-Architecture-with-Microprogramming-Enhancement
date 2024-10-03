

`timescale 1ns / 1ns

module ImmGen_tb();


	// Define inputs as register
	reg [31:0] Data ;
	reg [1:0] ImmSel;

	// Define output as wire
	wire [31:0] Immout;


	ImmGen DUT(.Data(Data),.ImmSel(ImmSel),.Immout(Immout));

	initial begin

		// Test case 1
		Data   <= 32'hffffffff;
		ImmSel <= 2'b00;
		//Expected output is 32'h0000ffff
		
		#10
		// Test case 2
		Data   <= 32'h0000ffff;
		ImmSel <= 2'b01;
		//Expected output is 32'hffffffff
		
		#10
		// Test case 3
		Data   <= 32'hffffffff;
		ImmSel <= 2'b10;
		//Expected output is 32'h03ffffff
		
		#10
		// Test case 4
		Data   <= 32'h03ffffff;
		ImmSel <= 2'b11;
		//Expected output is 32'hffffffff
	
		#10 $stop;





	end
endmodule