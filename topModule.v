`timescale 1ns / 1ps
/*module datapath(
		output [6:0] IW2Contr,
		output [15:0] pcOut, z, p2,
		input [31:0] IW,
		input [15:0] memOut,
		input LPC, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst,
		input [1:0] selM1, selM2, selM3, fnSel);*/

/*module controller(
		input [6:0] IW2Contr,
		input rstIn, clk,
		output LPC,
		output reg rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst, rdM, wrM_contr,
		output reg [1:0] selM1, selM2, selM3, fnSel);*/
		
/*module Imem(
		output [31:0] IW,
		input[15:0] pcOut);*/

/*module Dmem(
		output reg [15:0] memOut,
		input [15:0] Addr (z), memIn (p2),
		input rdM, wrM_contr, clk);*/
module topModule(
		input clk, rstIn);
		
	wire LPC, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst, rdM, wrM_contr;
	wire [1:0] selM1, selM2, selM3, fnSel;
	wire [6:0] IW2Contr;
	wire [15:0] pcOut, z, p2, memOut;
	wire [31:0] IW;
	
	datapath dp(IW2Contr, pcOut, z, p2, IW, memOut, LPC, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst, selM1, selM2, selM3, fnSel);
	controller con(IW2Contr, rstIn, clk, LPC, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst, rdM, wrM_contr, selM1, selM2, selM3, fnSel);
	Imem imemM(IW, pcOut);
	Dmem dmemM(memOut, z, p2, rdM, wrM_contr, clk);
endmodule

module tb_topModule;
	reg clk, rstIn;
	
	topModule uut(clk, rstIn);
	
	// Clock generator
	initial
	begin
		clk = 1;
		forever #5 clk = ~clk;
	end
	
	initial
	begin
			rstIn = 0;
		#5; rstIn = 1;
	end
endmodule
