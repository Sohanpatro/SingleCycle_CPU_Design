`timescale 1ns / 1ps

module regBank(
		output [15:0] p1, p2,
		input [15:0] Din,
		input [2:0] rpa1, rpa2, wpa,
		input rd1, rd2, wr);
	wire[15:0] q0, q1, q2 ,q3 ,q4 ,q5 ,q6 ,q7;
	wire[7:0] wpaOut, t, u;
	decoder3_8 decm(wpaOut, wpa);
	
	and(ld0, wr, wpaOut[0]);
	and(ld1, wr, wpaOut[1]);
	and(ld2, wr, wpaOut[2]);
	and(ld3, wr, wpaOut[3]);
	and(ld4, wr, wpaOut[4]);
	and(ld5, wr, wpaOut[5]);
	and(ld6, wr, wpaOut[6]);
	and(ld7, wr, wpaOut[7]);
	
	register_16 r0(q0, Din, ld0, rst),
					r1(q1, Din, ld1, rst),
					r2(q2, Din, ld2, rst),
					r3(q3, Din, ld3, rst),
					r4(q4, Din, ld4, rst),
					r5(q5, Din, ld5, rst),
					r6(q6, Din, ld6, rst),
					r7(q7, Din, ld7, rst);
	
	demux1_8 dmm1(t, rd1, rpa1);
	
	triStateBuffer tsbt0(p1, q0, t[0]),
						tsbt1(p1, q1, t[1]),
						tsbt2(p1, q2, t[2]),
						tsbt3(p1, q3, t[3]),
						tsbt4(p1, q4, t[4]),
						tsbt5(p1, q5, t[5]),
						tsbt6(p1, q6, t[6]),
						tsbt7(p1, q7, t[7]);

	demux1_8 dmm2(u, rd2, rpa2);
	
	triStateBuffer tsbu0(p2, q0, u[0]),
						tsbu1(p2, q1, u[1]),
						tsbu2(p2, q2, u[2]),
						tsbu3(p2, q3, u[3]),
						tsbu4(p2, q4, u[4]),
						tsbu5(p2, q5, u[5]),
						tsbu6(p2, q6, u[6]),
						tsbu7(p2, q7, u[7]);

endmodule
