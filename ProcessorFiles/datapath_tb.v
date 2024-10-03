`timescale 1ns/1ns
module datapath_tb();


	// Clock and reset signals 
	reg clock, reset;
	
	// generate clock
	always begin
		#10 clock <= ~clock;
	end
	
	dataPath dp( clock, reset );
	
	// initialize clock and reset
	initial begin 
		clock <= 0;
		reset <=1;
		#10 reset <=0;
		#1400;
		$stop;

	end
	

	
	

endmodule