module shift_left_twice #(parameter N = 32)(
	input [N-1:0] in,
	output [N-1:0] out
);
	assign out = in << 2;
endmodule