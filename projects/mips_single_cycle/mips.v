module mips(
	input clk,arst_n,
	input[31:0] instr,mem_read_data,
	output [31:0] current_inst,alu_out,mem_write_data,
	output mem_write
);
	wire zero,reg_write,reg_dest,alu_src,mem_to_reg,pc_src,jump;
	wire [2:0] alu_control;
	
	control_unit control_unit(
		.mem_write(mem_write),
		.reg_write(reg_write),
		.reg_dest(reg_dest),
		.alu_src(alu_src),
		.mem_to_reg(mem_to_reg),
		.pc_src(pc_src),
		.jump(jump),
		.alu_control(alu_control),
		.op_code(instr[31:26]),
		.funct(instr[5:0]),
		.zero(zero)
	);
	
	data_path data_path(
		.current_inst(current_inst),
		.alu_out(alu_out),
		.mem_write_data(mem_write_data),
		.zero(zero),
		.clk(clk),
		.arst_n(arst_n),
		.instr(instr[25:0]),
		.mem_read_data(mem_read_data),
		.reg_write(reg_write),
		.reg_dest(reg_dest),
		.alu_src(alu_src),
		.mem_to_reg(mem_to_reg),
		.pc_src(pc_src),
		.jump(jump),
		.alu_control(alu_control)
	);
	
	
endmodule 