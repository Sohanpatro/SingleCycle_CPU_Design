`timescale 1ns / 1ps

module alu(
		output[15:0] z,
		output c_n, c_n_minus_1,
		input[15:0] x, y,
		input [2:0] fnsel);

	wire [15:0] cmpOut, orOut, andOut, y1, addsubOut;
	
	xor_16_1 xm(y1, y, fnsel[0]);
	adder_16 addm(addsubOut, c_n, c_n_minus_1, x, y1, fnsel[0]);
	
	and_16 andm(andOut, x, y);
	
	or_16 om(orOut, x, y);
	
	cmp_16 cm(cmpOut, x);
	
	mux8_1_16 mm(z, addsubOut, addsubOut, andOut, orOut, 16'bXXXXXXXXXXXXXXXX, cmpOut, x, 16'bXXXXXXXXXXXXXXXX, fnsel);

endmodule

module tb_alu;
	reg[15:0] x, y;
	reg[2:0] fnsel;
	wire [15:0] z;
	wire c_n, c_n_minus_1;
	
	alu m(z, c_n, c_n_minus_1, x, y, fnsel);
	
	initial
	begin
		x = 5; y = 12;
		#10 fnsel = 0;
		#10 fnsel = 2;
		#10 fnsel = 1;
		#10 fnsel = 3;
		#10 fnsel = 0;
		#10 fnsel = 5;
		#10 fnsel = 4;
		#10 fnsel = 6;
		#10 fnsel = 7;
		#10 $finish;
	end
endmodule
