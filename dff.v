`timescale 1ns / 1ps

module dff(
		output reg q, nq,
		input d,
		input ld, rst);
	//reg q, nq;
	always @ (posedge ld or negedge rst)
	begin
		if(rst == 0)
			q <= 0;
		else
			begin
				q <= d;
				nq <= ~d;
			end
	end

	//assign nq <= q;
endmodule

module tb_dff;
	reg d;
	reg ld, rst;
	wire q, nq;
	
	dff m(q, nq, d, ld, rst);
	
	initial
	begin
		rst=0; d=1;
		#10 ld=1;
		#10 rst=1;
		#10 ld=0;
		#10 ld=1;
		#10 d=0;
		#10 ld=0;
		#10 ld=1;
		#10 ld=0; rst=0;
	end
endmodule
