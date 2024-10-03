/************************************************************************/
/* Team Number :        12                                              */
/* Name:                ID:      	serial # :                          */
/* Issa Qandah          2036177         11                              */
/* Hassan Taqieddin     2036057         18                              */
/* Thaer Eid            2035027         31                              */
/************************************************************************/
module mux_64x1(r0 , r1, r2, r3, r4, r5, r6, r7, r8, r9, r10,
				r11, r12, r13, r14, r15, r16, r17, r18, r19, r20,
				r21, r22, r23, r24, r25, r26, r27, r28, r29, r30,
				r31, r32, r33, r34, r35, r36, r37, r38, r39, r40,
				r41, r42, r43, r44, r45, r46, r47, r48, r49, r50,
				r51, r52, r53, r54, r55, r56, r57, r58, r59, r60,
				r61, r62, r63, out, s);
	
	parameter SEL_WIDTH = 6;
	parameter DATA_WIDTH = 32;
	// Inputs
	input [DATA_WIDTH-1:0]   r0 , r1, r2, r3, r4, r5, r6, r7, r8, r9, r10,
							 r11, r12, r13, r14, r15, r16, r17, r18, r19, r20,
							 r21, r22, r23, r24, r25, r26, r27, r28, r29, r30,
							 r31, r32, r33, r34, r35, r36, r37, r38, r39, r40,
							 r41, r42, r43, r44, r45, r46, r47, r48, r49, r50,
							 r51, r52, r53, r54, r55, r56, r57, r58, r59, r60,
							 r61, r62, r63;
	
	// 6-bit selector line
	input [SEL_WIDTH -1:0] s;	
	
	// Output
	output reg [DATA_WIDTH-1:0] out;

	always @(*)
	case (s)
		
		6'd0: out <= r0;
		6'd1: out <= r1;
		6'd2: out <= r2;
		6'd3: out <= r3;
		6'd4: out <= r4;
		6'd5: out <= r5;
		6'd6: out <= r6;
		6'd7: out <= r7;
		6'd8: out <= r8;
		6'd9: out <= r9;
		6'd10: out <= r10;
		6'd11: out <= r11;
		6'd12: out <= r12;
		6'd13: out <= r13;
		6'd14: out <= r14;
		6'd15: out <= r15;
		6'd16: out <= r16;
		6'd17: out <= r17;
		6'd18: out <= r18;
		6'd19: out <= r19;
		6'd20: out <= r20;
		6'd21: out <= r21;
		6'd22: out <= r22;
		6'd23: out <= r23;
		6'd24: out <= r24;
		6'd25: out <= r25;
		6'd26: out <= r26;
		6'd27: out <= r27;
		6'd28: out <= r28;
		6'd29: out <= r29;
		6'd30: out <= r30;
		6'd31: out <= r31;
		6'd32: out <= r32;
		6'd33: out <= r33;
		6'd34: out <= r34;
		6'd35: out <= r35;
		6'd36: out <= r36;
		6'd37: out <= r37;
		6'd38: out <= r38;
		6'd39: out <= r39;
		6'd40: out <= r40;
		6'd41: out <= r41;
		6'd42: out <= r42;
		6'd43: out <= r43;
		6'd44: out <= r44;
		6'd45: out <= r45;
		6'd46: out <= r46;
		6'd47: out <= r47;
		6'd48: out <= r48;
		6'd49: out <= r49;
		6'd50: out <= r50;
		6'd51: out <= r51;
		6'd52: out <= r52;
		6'd53: out <= r53;
		6'd54: out <= r54;
		6'd55: out <= r55;
		6'd56: out <= r56;
		6'd57: out <= r57;
		6'd58: out <= r58;
		6'd59: out <= r59;
		6'd60: out <= r60;
		6'd61: out <= r61;
		6'd62: out <= r62;
		6'd63: out <= r63;
		default : out <= 32'bx;

	endcase
endmodule