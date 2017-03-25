`timescale 1ns / 1ps
module Dmem(
		output reg [15:0] memOut,
		input [15:0] Addr, memIn,
		input rdM, wrM_contr, clk);
	wire wrM;
	reg [15:0] M[0:65/*535*/];
	
	assign wrM = wrM_contr && (~clk);
	
	always@(posedge rdM or posedge wrM)
	begin
		if(rdM == 1)
			memOut <= M[Addr];
		else if (wrM == 1)
			M[Addr] <= memIn;
	end

endmodule
