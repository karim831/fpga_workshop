module reg_file(
	input clk,we,
	input [4:0] a1,a2,a3,
	input [31:0] wd,
	output rd1,rd2
);

	reg [31:0] sram [0:31];
	
	assign rd1 = sram[a1];
	assign rd2 = sram[a2];
	
	always @(posedge clk)begin
		if(we)
			sram[a3] <= wd;
	end
endmodule