`timescale 1ns / 1ps

module demux1_8(
		output reg [7:0] o,
		input i,
		input [2:0] sel);
	always @ (i or sel)
//	begin
//		case(sel)
//			0: begin o0 <= 1; o1 <= 0; o2 <= 0; o3 <= 0; o4 <= 0; o5 <= 0; o6 <= 0; o7 <= 0; end
//			1: begin o0 = 0; o1 = 1; o2 = 0; o3 = 0; o4 = 0; o5 = 0; o6 = 0; o7 = 0; end
//			2: begin o0 = 0; o1 = 0; o2 = 1; o3 = 0; o4 = 0; o5 = 0; o6 = 0; o7 = 0; end
//			3: begin o0 = 0; o1 = 0; o2 = 0; o3 = 1; o4 = 0; o5 = 0; o6 = 0; o7 = 0; end
//			4: begin o0 = 0; o1 = 0; o2 = 0; o3 = 0; o4 = 1; o5 = 0; o6 = 0; o7 = 0; end
//			5: begin o0 = 0; o1 = 0; o2 = 0; o3 = 0; o4 = 0; o5 = 1; o6 = 0; o7 = 0; end
//			6: begin o0 = 0; o1 = 0; o2 = 0; o3 = 0; o4 = 0; o5 = 0; o6 = 1; o7 = 0; end
//			7: begin o0 = 0; o1 = 0; o2 = 0; o3 = 0; o4 = 0; o5 = 0; o6 = 0; o7 = 1; end
//		endcase
		case(sel)
			7: o = {i, 7'b0000000};
			6: o = {1'b0, i, 6'b000000};
			5: o = {2'b00, i, 5'b00000};
			4: o = {3'b000, i, 4'b0000};
			3: o = {4'b0000, i, 3'b000};
			2: o = {5'b00000, i, 2'b00};
			1: o = {6'b000000, i, 1'b0};
			0: o = {7'b0000000, i};
			default: o = 8'b00000000;
		endcase
//	end

endmodule

module tb_demux1_8;
	reg [2:0] sel;
	reg i;
	wire [2:0] o;
	
	demux1_8 m(o, i, sel);
	
	initial
	begin
		i=1; sel=3;
		#10 sel=5;
		#10 i=0;
		#10 sel=4;
		#10 sel=7; i=1;
	end
endmodule
