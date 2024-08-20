module data_mem(
	input clk,we,
	input [31:0] a, wd,
	output [31:0] rd,
	output [15:0] test_value
);
	reg [31:0] dram [0:255];
	
	assign rd = dram[a[9:2]];
	
	assign test_value = dram[8'h00][15:0];
	
	always @(posedge clk)begin
		if(we)
			dram[a[9:2]] <= wd;
	end

endmodule