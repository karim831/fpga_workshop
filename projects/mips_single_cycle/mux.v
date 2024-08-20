module mux #(parameter N = 32)(
	input [N-1:0] in1,in2,
	input sel,
	output [N-1:0] out
);
	assign out = !sel ? in1 : in2;
endmodule	