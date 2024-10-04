/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/************************************************************************/
`timescale 1ns/1ns
module Memory_tb();


	parameter ADDR_WIDTH = 32;
	parameter DATA_WIDTH = 32;
	parameter MEM_WIDTH  = 32;
	// Inputs
	
	// clock and reset
	reg clock;
	// 32 bit address ,determines which Memory location  to read or written to
	reg [ADDR_WIDTH-1:0] addr ;
	// if MemWrt is 1, then it is a write, otherwise it’s a read
	reg MemWrt;
	// General enable control for the Memory 
	reg enMem;
	// 32 bit bidirectional data port
	reg [DATA_WIDTH-1:0] data;
	wire [31:0] dataIn;
	// Output
	wire Busy;
	assign dataIn = (~enMem || MemWrt) ? data : 32'bZ;

	// inistanciate the memory modulen
	Memory mem ( .addr(addr), .data(dataIn), .MemWrt(MemWrt), .enMem(enMem), .clock(clock), .Busy(Busy));

	// generate clock
	always begin
		#5 clock <= ~clock;
	end
	
	// initialize clock and reset
	initial begin 
		clock <= 0;

	end
	integer i;
	
	initial begin
	
		
		// write on all locations
		MemWrt <= 1;
		enMem <= 1;
		for ( i=0; i<32; i = i+1 )	begin
			data <= i;
			addr <= i;
			#10;
		end
		
		// read from all locations (backward)
		MemWrt <= 0;
		//enMem <= 1;
		for ( i=31; i>=0; i = i-1 )	begin
			addr <= i;
			#10;
		end
		
		// try to write zero on all locations while enable is deactivated
		MemWrt <= 1;
		enMem <= 0;
		for ( i=0; i<32; i = i+1 )	begin
			data <= 0;
			addr <= i;
			#10;
		end
		
		// write zero on all registers
		MemWrt <= 1;
		enMem <= 1;
		for ( i=0; i<32; i = i+1 )	begin
			data <= 0;
			addr <= i;
			#10;
		end
		
		// stop simulation
		#10;
		$stop();
		
	end





endmodule
