module control_unit(
	input [5:0] op_code,
	input [5:0] funct,
	output [2:0] alu_control,
	output jump,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch
);

	wire [1:0] alu_op;
	
	main_decoder  main_decoder(
		.alu_op(alu_op),
		.jump(jump),
		.mem_w(mem_w),
		.reg_w(reg_w),
		.reg_dest(reg_dest),
		.alu_src(alu_src),
		.mem_to_reg(mem_to_reg),
		.branch(branch),
		.op_code(op_code)
	);
	
	alu_decoder alu_decoder(
		.alu_control(alu_control),
		.funct(funct),
		.alu_op(alu_op)
	);

endmodule
	