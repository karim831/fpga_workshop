module inst_mem(
	input [31:0] current_inst,
	output [31:0] fetched_inst
);
	reg [31:0] rom [0:255];
	
	initial begin
        $readmemh("D:/Studying/programming/fpga_workshop/verilog_codes/projects/mips_single_cycle/instructions.txt",rom);
    end
	
	assign fetched_inst = rom[current_inst[9:2]];
endmodule