module muxDcondn(
		output reg Dcondn,
		input iu, iz, inz, ic, inc, iv, inv, is, ins,
		input[3:0] IR12_9);
	//reg[15:0] o;
	
	always @ (iu, iz, inz, ic, inc, iv, inv, is, ins, IR12_9)
	case(IR12_9)
		4'b0000: begin Dcondn= iu; /*$display("Dcondn = iu\n");*/ end
		4'b1000: begin Dcondn= iz; /*$display("Dcondn = iz\n");*/ end
		4'b1001: begin Dcondn= inz; /*$display("Dcondn = inz\n");*/ end
		4'b1010: begin Dcondn= ic; /*$display("Dcondn = ic\n");*/ end
		4'b1011: begin Dcondn= inc; /*$display("Dcondn = inc\n");*/ end
		4'b1100: begin Dcondn= iv; /*$display("Dcondn = iv\n");*/ end
		4'b1101: begin Dcondn= inv; /*$display("Dcondn = inv\n");*/ end
		4'b1110: begin Dcondn= is; /*$display("Dcondn = is\n");*/ end
		4'b1111: begin Dcondn= ins; /*$display("Dcondn = ins\n");*/ end
	endcase

endmodule

module tb_muxDcondn;
	reg i0, i1, i2, i3, i4, i5, i6, i7, i8;
	reg[3:0] sel;
	wire o;
	
	muxDcondn m(o, i0, i1, i2, i3, i4, i5, i6, i7, i8, sel);
	
	initial
	begin
		i0=1;
		i1=1;
		i2=1;
		i3=1;
		i4=1;
		i5=1;
		i6=1;
		i7=1;
		i8=1;
		// i2=2; i3=3; i4=4; i5 = 5; i6=6; i7=7; i8
		//#10 sel=4'b0XXX;
		#10 sel=4'b1011;
		#10 sel=4'b1000;
		#10 sel=4'b1110;
		#10 sel=4'b1010;
		#10 sel=4'b1001;
		#10 sel=4'b0000;
		#10 sel=4'b1100;
		//#10 sel=4'b0111;
		#10 sel=4'b1101;
		#10 sel=4'b1111;
		//#10 sel=4'b0X1X;
		#10 sel=4'b1101;
		#10 sel=4'b1110;
	end
endmodule
