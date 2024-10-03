/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
module ImmGen(Data,ImmSel,Immout);

	/* Inputs */
	
	// 32 bit data input ( IR )
	input wire [31:0] Data ; 
	// 2 bit selector to select the suitable extended immediate for each type
	input wire [1:0] ImmSel;
	
	/* Output */
	
	// 32 bit output ( extended immediate)
	output wire [31:0] Immout; 
	
	// Immediates for I, S and B types ( each 12 bits )
	wire [11:0] I ,S, B;
	// Immediate f for J type (20 bits)
	wire [19:0] J;
	// Concatinating the immediates
	assign I = Data[31:20];
	assign S = { Data[31:25] , Data[11:7] };
	assign B = { Data[12], Data[7], Data[30:25], Data[11:8]};
	assign J = { Data[31], Data[19:12], Data[20], Data[30:21] };

	assign Immout = (ImmSel==2'b00) ? {{20{I[11]}}, I[11:0]}  // If ExSel is I_imm12
				  : (ImmSel==2'b01) ? {{20{S[11]}}, S[11:0]}  // If ExSel is S_imm12
				  : (ImmSel==2'b10) ? {{{18{B[11]}},B[11:0],1'b0},2'b00}  // If ExSel is B_imm12
				  : (ImmSel==2'b11) ? {{{9{J[19]}},J[19:0],1'b0},2'b00} // if ExSel is J_imm20
				  : 32'bx;
				  
endmodule			
 