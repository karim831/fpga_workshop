module data_path(
	input clk,arst_n,reg_write,reg_dest,alu_src,mem_to_reg,pcsrc,jump,
	input [2:0] alu_control,
	input [25:0] instr,
	input [31:0] mem_read_data,
	output [31:0] current_inst,alu_out,mem_write_data,
	output zero_flag
);	
	// pc
	reg [1:0] pc_counter;
	wire [31:0] next_inst;
	
	// reg file 
	reg [1:0] reg_counter;
	wire [31:0] rd1,rd2;
	wire [4:0] a3;
	wire [31:0] wd;
	assign mem_write_data = rd2;
	
	// alu src_b
	wire [31:0] src_b;
	
	// sign extend out
	wire [31:0] sign_imm;
	
	// mux_responsible_for_branch 
	wire [31:0] branch_out,pc_plus4,pc_branch;
		
	// mux responsible for jump
	wire [31:0] pc_jump;
	
	// shift left responsible for input pc_branch
	wire [31:0] sign_imm_shifted;
	
	//shift left responsible for inpu pc_jump
	wire [27:0] jump_shifted; 
	assign pc_jump = {pc_plus4[31:28],jump_shifted};
	
	
	// for process flow
	always @(posedge clk,negedge arst_n)begin
		if(!arst_n)begin
			pc_counter <= 2'b10; // start when rst
			reg_counter <= 2'b00; // delay 2 cycle
		end
		else begin
			pc_counter <= pc_counter + 1'b1;
			reg_counter <= reg_counter + 1'b1;
		end
	end
	
	pc program_counter(.current_inst(current_inst),.clk(pc_counter[1]),.arst_n(arst_n),.next_inst(next_inst));
	
	reg_file reg_file(
		.rd1(rd1),.rd2(rd2),.clk(reg_counter[1]),.we(reg_write),.a1(instr[25:21]),.a2(instr[20:16]),.a3(a3),.wd(wd)
	);
	
	alu alu(.alu_result(alu_out),.zero_flag(zero_flag),.src_a(rd1),.src_b(src_b),.alu_control(alu_control));
	
	mux mux_alu_src(.out(src_b),.in1(rd2),.in2(sign_imm),.sel(alu_src));
	
	mux #(5) mux_reg_dest(.out(a3),.in1(instr[20:16]),.in2(instr[15:11]),.sel(reg_dest));
	
	mux mux_branch(.out(branch_out),.in1(pc_plus4),.in2(pc_branch),.sel(pc_src));
	
	mux mux_jumb(.out(next_inst),.in1(branch_out),.in2(pc_jump),.sel(jump));
	
	mux mux_result(.out(wd),.in1(alu_out),.in2(mem_read_data),.sel(mem_to_reg));
	
	sign_extend sign_extend(.out(sign_imm),.in(instr[15:0]));
	
	shift_left_twice sll_branch(.out(sign_imm_shifted),.in(sign_imm));
	
	shift_left_twice #(26,28) sll_jump(.out(jump_shifted),.in(instr[25:0]));
	
	alu adder_branch(.alu_result(pc_branch),.zero_flag(null),.src_a(sign_imm_shifted),.src_b(pc_plus4),.alu_control(3'b000));
	
	alu adder_counter(.alu_result(pc_plus4),.zero_flag(null),.src_a(current_inst),.src_b(32'd4),.alu_control(3'b000));
	
	
endmodule