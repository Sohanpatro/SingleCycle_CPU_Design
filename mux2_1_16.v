`timescale 1ns / 1ps

module mux2_1_16(
		output reg [15:0] o,
		input [15:0] i0, i1,
		input sel);
//	not(nsel, sel);
//	and(t1, i0, nsel), (t2, i1, sel);
//	or(o, t1, t2);
	always @(sel, i0, i1)
	case(sel)
		0: o = i0;
		1: o = i1;
	endcase
endmodule

module tb_mux2_1_16;
	reg [15:0] i0, i1;
	reg sel;
	wire [15:0] o;
	
	mux2_1_16 m(o, i0, i1, sel);
	
	initial
	begin
		i0=30; i1=17;
		#10 sel=0;
		#10 sel=1;
		#10 sel=1;
		#10 sel=0;
		#10 sel=0;
		#10 sel=1;
	end
endmodule
