module alu_decoder(
	input [1:0] alu_op,
	input [5:0] funct,
	output [2:0] alu_control
);
	always @(*)begin
		if(alu_op == 2'b10)begin
			case(funct)
				6'b10_0000 : alu_conrol = 3'b010;
				6'b10_0010 : alu_conrol = 3'b100;
				6'b10_1010 : alu_conrol = 3'b110;
				6'b01_1100 : alu_conrol = 3'b101;
			endcase
		end
		else if(alu_op == 2'b01)
			alu_control = 3'b100;
		else
			alu_control = 3'b010;
	end 
endmodule