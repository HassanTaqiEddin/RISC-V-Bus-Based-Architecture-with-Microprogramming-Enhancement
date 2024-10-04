/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/************************************************************************/
module Memory ( addr, data, MemWrt, enMem, clock, Busy);
	
	parameter ADDR_WIDTH = 32;
	parameter DATA_WIDTH = 32;
	parameter MEMORY_DIPTH = 256;

	// Inputs
	
	// clock and reset
	input clock;
	// 32 bit address ,determines which Memory location  to read or written to
	input [ADDR_WIDTH-1:0] addr ;
	// if MemWrt is 1, then it is a write, otherwise it’s a read
	input MemWrt;
	// General enable control for the Memory 
	input enMem;
	// 32 bit bidirectional data port
	inout [DATA_WIDTH-1:0] data;
	// Busy signal
	output Busy ;
	
	// Creating the memory vector
	reg [7:0] MEM [0: MEMORY_DIPTH - 1];
	
	//Initialize memory 
	initial begin
		$readmemh("Memory_init.txt", MEM);
	end
	
	// write operation on posedge of the clock,while the enable is activated
	always @ ( posedge clock  ) begin
		
		if ( enMem && MemWrt ) begin

			MEM[addr+3] <= data [7:0];
			MEM[addr+2] <= data [15:8];
			MEM[addr+1] <= data [23:16];
			MEM[addr] <= data [31:24];

		end 
			
	end
	
	// Read operation
	assign data = (enMem && ~MemWrt) ?{ MEM[addr], MEM[addr + 1], MEM[addr + 2], MEM[addr + 3] }  : 32'bZ;
	
	assign Busy = (enMem) ? 1'b1: 1'b0 ;

endmodule
