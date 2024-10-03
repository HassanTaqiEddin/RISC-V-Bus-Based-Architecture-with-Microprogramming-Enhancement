/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
`timescale 1ns/1ns
module registerFile_tb();
	
	// clock and reset
	reg clock, reset;
	// 6 bit address ,determines which register is to be read or written to
	reg [5:0] addr ;
	// if RegWr is 1, then it is a write, otherwise it’s a read
	reg RegWrt;
	// output enable to control writing on the bus
	reg enReg;
	// 32 bit bidirectional data port
	reg [31:0] data;
	wire [31:0] dataIn;
	assign dataIn = (~enReg || RegWrt) ? data : 32'bZ;
	// inistantiate the registerFile 
	registerFile regFile( addr, dataIn, RegWrt, enReg, clock, reset);
	
	// generate clock
	always begin
		#5 clock <= ~clock;
	end
	
	// initialize clock and reset
	initial begin 
		clock <= 0;
		reset <=0;
		#5 reset <=1;
	end
	integer i;
	
	initial begin
	
		
		// write on all registers
		RegWrt <= 1;
		enReg <= 1;
		for ( i=0; i<33; i = i+1 )	begin
			data <= i;
			addr <= i;
			#10;
		end
		#10;
		
		// read from all registers (backward)
		RegWrt <= 0;
		enReg <= 1;
		for ( i=32; i>=0; i = i-1 )	begin
			addr <= i;
			#10;
		end
		
		// try to write zero on all registers while enable is deactivated
		RegWrt <= 1;
		enReg <= 0;
		for ( i=0; i<33; i = i+1 )	begin
			data <= 0;
			addr <= i;
			#10;
		end
		
		// write zero on all registers
		RegWrt <= 1;
		enReg <= 1;
		for ( i=0; i<33; i = i+1 )	begin
			data <= 0;
			addr <= i;
			#10;
		end
		
		// stop simulation
		#10;
		$stop();
		
	end
	
endmodule