`timescale 1ns / 1ps

module mux8_1_16(
		output reg [15:0] o,
		input[15:0] i0, i1, i2, i3, i4, i5, i6, i7,
		input[2:0] sel);
	//reg[15:0] o;
	
	always @ (i0 or i1 or i2 or i3 or i4 or i5 or i6 or i7 or sel)
	case(sel)
		0: o= i0;
		1: o= i1;
		2: o= i2;
		3: o= i3;
		4: o= i4;
		5: o= i5;
		6: o= i6;
		7: o= i7;
	endcase

endmodule

module tb_mux8_1_16;
	reg[15:0] i0, i1, i2, i3, i4, i5, i6, i7;
	reg[2:0] sel;
	wire[15:0] o;
	
	mux8_1_16 m(o, i0, i1, i2, i3, i4, i5, i6, i7, sel);
	
	initial
	begin
		i0=0; i1=1; i2=2; i3=3; i4=4; i5 = 5; i6=6; i7=7;
		#10 sel=0;
		#10 sel=1;
		#10 sel=2;
		#10 sel=3;
		#10 sel=4;
		#10 sel=5;
		#10 sel=6;
		#10 sel=7;
		#10 sel=6;
		#10 sel=1;
	end
endmodule
