module harvard(
	input clk,arst_n,
	output [15:0] test_value
);
	wire mem_write,mem_clk;
	wire [31:0] current_inst,alu_out,mem_write_data,instr,mem_read_data;
	mips mips(
		.mem_write(mem_write),
		.mem_clk(mem_clk),
		.current_inst(current_inst),
		.alu_out(alu_out),
		.mem_write_data(mem_write_data),
		.instr(instr),
		.mem_read_data(mem_read_data),
		.clk(clk),
		.arst_n(arst_n)
	);
	
	inst_mem inst_mem(
		.fetched_inst(instr),
		.current_inst(current_inst)
	);
	
	data_mem data_mem(
		.test_value(test_value),
		.rd(mem_read_data),
		.wd(mem_write_data),
		.a(alu_out),
		.we(mem_write),
		.clk(mem_clk)
	);
endmodule