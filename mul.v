module reg_file(input wire clk,reset,test,cout,input wire [15:0]sum,output wire [15:0] prod);
	wire [15:0] r0;
	read re1(clk,r0,prod);
	write w1(clk,reset,cout,sum,r0);
endmodule

module seq_mul (input wire clk, reset, test, input wire [7:0] mul, b, output wire [15:0] prod);
	wire [15:0]sum;
	wire carry,cout;
	alu_slice a1(test,prod,mul,sum,cout) ;
	reg_file rf1(clk,reset,test,cout,sum,prod); 
endmodule

module read (input wire clk, input wire [15:0] x, output wire [15:0] y);
	assign y[0] = x[0];
	assign y[1] = x[1];
	assign y[2] = x[2];
	assign y[3] = x[3];
	assign y[4] = x[4];
	assign y[5] = x[5];
	assign y[6] = x[6];
	assign y[7] = x[7];
	assign y[8] = x[8];
	assign y[9] = x[9];
	assign y[10] = x[10];
	assign y[11] = x[11];
	assign y[12] = x[12];
	assign y[13] = x[13];
	assign y[14] = x[14];
	assign y[15] = x[15];
endmodule

module write(input wire clk,reset,cout, input wire [15:0] sum,output [15:0] out);
	wire test = 1'b1;
	dfrl p0(clk,reset,test,sum[1],out[0]);
	dfrl p1(clk,reset,test,sum[2],out[1]);
	dfrl p2(clk,reset,test,sum[3],out[2]);
	dfrl p3(clk,reset,test,sum[4],out[3]);
	dfrl p4(clk,reset,test,sum[5],out[4]);
	dfrl p5(clk,reset,test,sum[6],out[5]);
	dfrl p6(clk,reset,test,sum[7],out[6]);
	dfrl p7(clk,reset,test,sum[8],out[7]);
	dfrl p8(clk,reset,test,sum[9],out[8]);
	dfrl p9(clk,reset,test,sum[10],out[9]);
	dfrl p10(clk,reset,test,sum[11],out[10]);
	dfrl p11(clk,reset,test,sum[12],out[11]);
	dfrl p12(clk,reset,test,sum[13],out[12]);
	dfrl p13(clk,reset,test,sum[14],out[13]);
	dfrl p14(clk,reset,test,sum[15],out[14]);
	dfrl p15(clk,reset,test,cout,out[15]);
endmodule

module alu_slice(input wire test,input wire[15:0] a, input wire[7:0] b1, output wire [15:0] out, output wire carry);
	assign out[0] = a[0];
	assign out[1] = a[1];
	assign out[2] = a[2];
	assign out[3] = a[3];
	assign out[4] = a[4];
	assign out[5] = a[5];
	assign out[6] = a[6];
	assign out[7] = a[7];

	wire [7:0]b;
	and2 s1(test,b1[0],b[0]);
	and2 s2(test,b1[1],b[1]);
	and2 s3(test,b1[2],b[2]);
	and2 s4(test,b1[3],b[3]);
	and2 s5(test,b1[4],b[4]);
	and2 s6(test,b1[5],b[5]);
	and2 s7(test,b1[6],b[6]);
	and2 s8(test,b1[7],b[7]);

	wire [6:0] c;
	fa f1(a[8],b[0],1'b0,out[8],c[0]);
	fa f2(a[9],b[1],c[0],out[9],c[1]);
	fa f3(a[10],b[2],c[1],out[10],c[2]);
	fa f4(a[11],b[3],c[2],out[11],c[3]);
	fa f5(a[12],b[4],c[3],out[12],c[4]);
	fa f6(a[13],b[5],c[4],out[13],c[5]);
	fa f7(a[14],b[6],c[5],out[14],c[6]);
	fa f8(a[15],b[7],c[6],out[15],carry);
endmodule

module fa (input wire i0, i1, cin, output wire sum, cout);
	wire t0, t1, t2;
	xor3 _i0 (i0, i1, cin, sum);
	and2 _i1 (i0, i1, t0);
	and2 _i2 (i1, cin, t1);
	and2 _i3 (cin, i0, t2);
	or3 _i4  (t0, t1, t2, cout);
endmodule