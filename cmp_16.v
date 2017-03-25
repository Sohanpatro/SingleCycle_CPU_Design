`timescale 1ns / 1ps

module cmp_16(
		output [15:0] o,
		input[15:0] i);
	wire[15:0] t;
	genvar j;
	generate for(j=0; j <= 15; j=j+1)
	begin:loop
		not(t[j], i[j]);
	end
	endgenerate

	//module adder_16 (sum, c_n, c_n_minus_1, a, b, cin);
	adder_16 m(o, cn, cn1, t, 16'b0000000000000000, 1'b1);
endmodule

module tb_cmp_16;
	reg [15:0] i;
	wire [15:0] o;
	
	cmp_16 m(o, i);
	
	initial
	begin
		i=2;
		#10 i = 2**15 -1;
		#10 i = -5;
		#10 i=-2**15;
		#0.001 $finish;
	end
endmodule
