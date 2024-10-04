/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/************************************************************************/
module registerFile ( addr, data, RegWrt, enReg, clock, reset);
	
	parameter ADDR_WIDTH = 6;
	parameter DATA_WIDTH = 32;
	parameter NUMOF_REGS=33;
	
	// clock and reset
	input clock, reset;
	// 6 bit address ,determines which register is to be read or written to
	input [ADDR_WIDTH-1:0] addr ;
	// if RegWr is 1, then it is a write, otherwise it’s a read
	input RegWrt;
	// output enable to control writing on the bus
	input enReg;
	// 32 bit bidirectional data port
	inout [DATA_WIDTH-1:0] data;
	// 33 enable signals for 33 registers
	wire [NUMOF_REGS-1:0] rEn;
	// output of the 64 x 1 mux
	wire [DATA_WIDTH-1:0] readReg;
	// outputs of the registers , 32 bit GPR + PC reg which is r[32]
	wire [DATA_WIDTH-1:0] r [0:NUMOF_REGS-1];
	
	// decoder to activate the desired register enable signal 
	decoder addrDec( .in(addr), .out(rEn));
	
	// write operation on posedge of the clock,while the enable is activated
	genvar i;
	generate 
		
		for (i=0; i<NUMOF_REGS; i = i+1) begin : Registers
			register _r  ( .in(data), .reset(reset), .en( RegWrt && enReg && rEn[i] &&(addr != 0) ), .clk(clock), .R(r[i]) );
		end
	
	endgenerate
	

	// mux to select which regester to read from
	 mux_64x1 mx (  .r0(r[0]), .r1(r[1]), .r2(r[2]), .r3(r[3]), .r4(r[4]), .r5(r[5]), .r6(r[6]), .r7(r[7]),
					.r8(r[8]), .r9(r[9]), .r10(r[10]), .r11(r[11]), .r12(r[12]), .r13(r[13]), .r14(r[14]), .r15(r[15]),
					.r16(r[16]), .r17(r[17]), .r18(r[18]), .r19(r[19]), .r20(r[20]), .r21(r[21]), .r22(r[22]), .r23(r[23]),
					.r24(r[24]), .r25(r[25]), .r26(r[26]), .r27(r[27]), .r28(r[28]), .r29(r[29]), .r30(r[30]), .r31(r[31]),
					.r32(r[32]), .out(readReg), .s(addr) );

	// read operation 
	assign data = (enReg & ~RegWrt) ? readReg : 32'bZ;
	
endmodule
