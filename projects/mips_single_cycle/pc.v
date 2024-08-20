module pc(
	input clk,arst_n,
	input [31:0] next_inst,
	output reg [31:0] current_inst
);

	always @(posedge clk,negedge arst_n)begin
		if(!arst_n)
			current_inst <= {32{1'b0}};
		else
			current_inst <= next_inst;
	end
endmodule