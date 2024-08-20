module main_decoder(
	input [5:0] op_code,
	output jump,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch,
	output [1:0] alu_op
);
	always @(*)begin
		{jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = {9{1'b0}};
		case(op_code)
			6'b10_0011 : {jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = 9'b0_00_0_1_0_1_1_0;
			6'b10_1011 : {jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = 9'b0_00_1_0_0_1_1_0;
			6'b00_0000 : {jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = 9'b0_10_0_1_1_0_0_0;
			6'b00_1000 : {jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = 9'b0_00_0_1_0_1_0_0;
			6'b00_0100 : {jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = 9'b0_01_0_0_0_0_0_1;
			6'b00_0010 : {jump,alu_op,mem_w,reg_w,reg_dest,alu_src,mem_to_reg,branch} = 9'b1_00_0_0_0_0_0_0;
		endcase
	end
	
endmodule 