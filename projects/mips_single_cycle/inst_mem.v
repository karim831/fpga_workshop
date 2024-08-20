module inst_mem(
	input [31:0] current_inst,
	output [31:0] fetched_inst
);
	reg [31:0] rom [0:255];
	
	assign fetched_inst = rom[current_inst[9:2]];
endmodule