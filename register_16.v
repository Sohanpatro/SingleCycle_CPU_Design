`timescale 1ns / 1ps
module register_16(
		output reg[15:0] q,
		input[15:0] d,
		input ld, rst);
	//reg[15:0] q;
	always @ (posedge ld or negedge rst)
	begin
		if(rst == 0)
			q <= 0;
		else
			q <= d;
	end

endmodule

module tb_register_16;
	reg [15:0] d;
	reg ld, rst;
	wire[15:0] q;
	
	register_16 m(q, d, ld, rst);
	
	initial
	begin
		rst=0; d=5;
		#10 ld=1;
		#10 rst=1;
		#10 ld=0;
		#10 ld=1;
		#10 d=3101;
		#10 ld=0;
		#10 ld=1;
		#10 ld=0; rst=0;
	end
endmodule
