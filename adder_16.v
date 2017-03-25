`timescale 1ns / 1ps

module full_adder ( a ,b ,c ,sum ,carry );

    output sum ;
    output carry ;

    input a ;
    input b ;
    input c ;
        
//    assign sum = a ^ b ^ c;  
//    assign carry = (a&b) | (b&c) | (c&a);
   // xor (t, a, b);
    //xor (sum, t1, c);
	 xor(sum, a, b, c);
    and (t1, a,b), (t2, b, c), (t3, c,a);
   // or (tt, t1, t2);
    or (carry, t1, t2, t3);
endmodule

module adder_16 (sum, c_n, c_n_minus_1, a, b, cin);

output [15:0] sum ;
output c_n, c_n_minus_1;

input [15:0] a ;
input [15:0] b ;
input cin;

wire [13:0] s;

full_adder u0 (a[0],b[0],cin,sum[0],s[0]);
full_adder u1 (a[1],b[1],s[0],sum[1],s[1]);
full_adder u2 (a[2],b[2],s[1],sum[2],s[2]);
//full_adder u3 (a[3],b[3],s[2],sum[3],carry);
full_adder u3 (a[3],b[3],s[2],sum[3],s[3]);
full_adder u4 (a[4],b[4],s[3],sum[4],s[4]);
full_adder u5 (a[5],b[5],s[4],sum[5],s[5]);
full_adder u6 (a[6],b[6],s[5],sum[6],s[6]);
full_adder u7 (a[7],b[7],s[6],sum[7],s[7]);

full_adder  u8(a[8],b[8],s[7],sum[8],s[8]);
full_adder  u9(a[9],b[9],s[8],sum[9],s[9]);
full_adder  u10(a[10],b[10],s[9],sum[10],s[10]);
full_adder  u11(a[11],b[11],s[10],sum[11],s[11]);
full_adder  u12(a[12],b[12],s[11],sum[12],s[12]);
full_adder  u13(a[13],b[13],s[12],sum[13],s[13]);
full_adder  u14(a[14],b[14],s[13],sum[14],c_n_minus_1);
full_adder  u15(a[15],b[15],c_n_minus_1, sum[15],c_n);

endmodule

module tb_adder_16;
	reg[15:0] a, b;
	reg cin;
	wire[15:0] sum;
	wire c_n, c_n_minus_1;
	
	adder_16 m(sum, c_n, c_n_minus_1, a, b, cin);
	
	initial
	begin
		cin=1;
		a = 2**15 - 1;
		b = 4;
		#10 a=3; b=5;
	end
	
	initial #10.001 $finish;
endmodule
