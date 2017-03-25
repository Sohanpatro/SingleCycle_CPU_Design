`timescale 1ns / 1ps

module mux4_1_3(
		output reg [2:0] o,
		input [2:0] i0, i1, i2, i3,
		input [1:0] sel);
//	not(nsel, sel);
//	and(t1, i0, nsel), (t2, i1, sel);
//	or(o, t1, t2);
	always @(sel, i0, i1, i2, i3)
	case(sel)
		2'b00: o = i0;
		2'b01: o = i1;
		2'b10: o = i2;
		2'b11: o = i3;
	endcase
endmodule

module tb_mux4_1_3;
	reg [2:0] i0, i1, i2, i3;
	reg [1:0] sel;
	wire [2:0] o;
	
	mux4_1_3 m(o, i0, i1, i2, i3, sel);
	
	initial
	begin
		i0=0; i1=1; i2 = 2; i3 = 3;
		#10 sel=0;
		#10 sel=1;
		#10 sel=2'b10;
		#10 sel=0;
		#10 sel=3;
		#10 sel=1;
	end
endmodule
