`timescale 1ns / 1ps

module triStateBuffer(
		output [15:0] b,
		input[15:0] a,
		input enable);
	assign b = (enable) ? a : 16'bzzzzzzzzzzzzzzzz;
	/*always@(a or enable)
		begin
			if(enable)
				b=a;
			else
				b=16'bz;
		end*/
	// STRUCTURAL- DOES NOT WORK !!!
	/*not(nen, enable);
	wire [15:0] t1, t2;
	genvar i;
	generate for(i=0; i <= 15; i = i+1)
	begin:loop
		//and(t1[i], enable, a[i]), (t2[i], nen, 1'bZ);
		//or(b[i], t1[i], t2[i]);
		mux2_1 m(b[i], 1'bZ, a[i], enable);
	end
	endgenerate*/
endmodule

module tb_triStateBuffer;
	reg [15:0] a;
	reg en;
	wire [15:0] b;
	
	triStateBuffer m(b, a, en);
	
	initial
	begin
		a = 30;
		#10 en=0;
		#10 en=1;
		#10 a=2;
		#10 a=5; en=0;
		#10 a=10; en=1;
	end
endmodule
