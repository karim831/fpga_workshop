module alu(
	input [31:0] src_a,src_b,
	input [2:0] alu_control,
	output reg [31:0] alu_result,
	output reg zero_flag
);
	
	always @(*)begin
		alu_result = {32{1'b0}};
		zero_flag = 1'b1;
		case(alu_control)
			3'b000 : alu_result = src_a & src_b;
			3'b001 : alu_result = src_a | src_b;
			3'b010 : alu_result = src_a + src_b;
			3'b100 : alu_result = src_a - src_b;
			3'b101 : alu_result = src_a * src_b;
			3'b110 : alu_result = src_a < src_b;
		endcase
		if(alu_result)
			zero_flag = 1'b0;
	end
endmodule