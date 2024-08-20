module shift_left_twice #(parameter N = 32,M = 32)(
	input [N-1:0] in,
	output [M-1:0] out
);
	assign out = {{(M-N){1'b0}},in} << 2;
endmodule