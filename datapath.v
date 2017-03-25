`timescale 1ns / 1ps

module datapath(
		output [6:0] IW2Contr,
		output [15:0] pcOut, z, p2,
		input [31:0] IW,
		input [15:0] memOut,
		input LPC, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst,
		input [1:0] selM1, selM2, selM3, fnSel);
//IW[31...25]; pcOut, Z, p2
//LPC, rd1, rd2, wr_contr, selM1, selM2, fnsel[1:0], selM3, isJumpInstr, isCallInstr, Lflag_contr;
//IW, memOut

	wire [15:0] pcIn, incPc, p1, Din, x, y;
	wire [2:0] aluSel, aluSel1;
	wire /*PCrst, */wr, mnsSel, Dcondn, c_n, c_n_minus_1, n2, n3, Lflag, andOut, orOut;
	
	// Instruction Word to controller
	assign IW2Contr[6] = IW[31];
	assign IW2Contr[5] = IW[30];
	assign IW2Contr[4] = IW[29];
	assign IW2Contr[3] = IW[28];
	assign IW2Contr[2] = IW[27];
	assign IW2Contr[1] = IW[26];
	assign IW2Contr[0] = IW[25];
	
	// PC stuff
	register_16 pc(pcOut, pcIn, LPC, PCrst);	//LPC = clk
	adder_16 pcAdder(incPc, , , pcOut, 16'b0000000000000001, 0);
	and(andOut, Dcondn, isJumpInstr);
	or(orOut, andOut, isCallInstr);
	mux2_1_16 muxpc(pcIn, incPc, z, orOut);
	
	// Register Bank
	assign wr = wr_contr & (~LPC);	// '.' LPC = clk
	regBank rgbnk(p1, p2, Din, IW[24:22], IW[22:19], IW[22:19], rd1, rd2, wr);
	
	// MUXes		
	mux4_1_16 m1(y, incPc, p1, IW[15:0], , selM1);
	mux4_1_16 m2(x, p1, p2, IW[15:0], , selM2);
	mux4_1_16 m3(Din, incPc, memOut, z, , selM3);
	
	//ALU
	mux4_1_3 muxfnsel(aluSel1, {IW[30], IW[29], IW[28]}, 3'b110, 3'b000, , fnSel);
	not(n2, aluSel1[1]), (n3, aluSel1[0]);
	and(mnsSel, aluSel1[2], n2, n3);
	mux2_1_3 muxmns(aluSel, aluSel1, 3'b001, mnsSel);
	alu aluop(z, c_n, c_n_minus_1, x, y, aluSel);
	assign Lflag = Lflag_contr & (~LPC);
	statusDetectors condflag(Dcondn, z, c_n, c_n_minus_1, Lflag, IW[28:25]);
	
endmodule

module tb_datapath;
//datapath(
//		output [6:0] IW2Contr,
//		output [15:0] pcOut, z, p2,
//		input [31:0] IW,
//		input [15:0] memOut,
//		input LPC, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst
//		input [1:0] selM1, selM2, selM3, fnSel);
	reg [31:0] IW;
	reg [15:0] memOut;
	reg clk, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst;
	reg [1:0] selM1, selM2, selM3, fnSel;
	
	wire [6:0] IW2Contr;
	wire [15:0] pcOut, z, p2;
	//reg clk;
	datapath uut(IW2Contr, pcOut, z, p2, IW, memOut, clk, rd1, rd2, wr_contr, isJumpInstr, isCallInstr, Lflag_contr, PCrst, selM1, selM2, selM3, fnSel);
	
	initial
	begin
		PCrst=1;
		#10 PCrst=0; IW=32'b10000000001100000000000000001111;
		wr_contr=1; selM2=2'b10; fnSel = 2'b01; selM3=2'b10;
	end
	
	initial
	begin
		clk=0;
		#10; clk=1;
		#5 clk = ~clk;
		#2; $finish;
	end
endmodule
