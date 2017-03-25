`timescale 1ns / 1ps
/*
module statusDetectors(
		output Zout, nZout, Cout, nCout, Vout, nVout, Sout, nSout,
		input [15:0] z,
		input c_n, c_n_minus_1, Lflag);
	//buf(Cin, c_n);
	
	// assign statement is allowed in Structural coding !!! :)
	assign Cin = c_n;
	
	xor(Vin, c_n, c_n_minus_1);
	
	assign Sin = z[15];
	
	nor(Zin, z[0], z[1], z[2], z[3], z[4], z[5], z[6], z[7], z[8], z[9], z[10], z[11], z[12], z[13], z[14], z[15]);

	dff m1(Zout, nZout, Zin, Lflag, rst),
		 m2(Cout, nCout, Cin, Lflag, rst),
		 m3(Vout, nVout, Vin, Lflag, rst),
		 m4(Sout, nSout, Sin, Lflag, rst);
endmodule*/

module statusDetectors(
		output Dcondn,
		input [15:0] z,
		input c_n, c_n_minus_1, Lflag,
		input [3:0] IR12_9);
	//buf(Cin, c_n);
	
	// assign statement is allowed in Structural coding !!! :)
	assign Cin = c_n;
	
	xor(Vin, c_n, c_n_minus_1);
	
	assign Sin = z[15];
	
	nor(Zin, z[0], z[1], z[2], z[3], z[4], z[5], z[6], z[7], z[8], z[9], z[10], z[11], z[12], z[13], z[14], z[15]);

	dff m1(Zout, nZout, Zin, Lflag, rst),
		 m2(Cout, nCout, Cin, Lflag, rst),
		 m3(Vout, nVout, Vin, Lflag, rst),
		 m4(Sout, nSout, Sin, Lflag, rst);

	muxDcondn DCon(Dcondn, 1'b1, Zout, nZout, Cout, nCout, Vout, nVout, Sout, nSout, IR12_9);
endmodule
