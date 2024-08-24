module harvard_tb();
	reg clk,arst_n;
	wire [15:0] test_value;
	
	
	harvard harv(
		.test_value(test_value),
		.clk(clk),
		.arst_n(arst_n)
	);
	
	always #50 clk <= ~clk;
	
	initial begin
		clk <= 1'b0;
		arst_n <= 1'b0;
		#10;
		arst_n <= 1'b1;
	end
endmodule