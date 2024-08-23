module reg_file(
	input clk,we,
	input [4:0] a1,a2,a3,
	input [31:0] wd,
	output [31:0] rd1,rd2
);

	reg [31:0] sram [0:31];
	
	assign rd1 = sram[a1];
	assign rd2 = sram[a2];
	
	initial sram[0] = 32'd0; // hard wired to ground
	
	always @(posedge clk)begin
		if(we && a3 != 5'd0)
			sram[a3] <= wd;
	end
endmodule