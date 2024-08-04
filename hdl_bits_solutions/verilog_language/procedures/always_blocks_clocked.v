module always_blocks_clocked(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   
);
    
    assign out_assign = a ^ b;
    
    always @(*)begin
        if((a && !b) || (!a && b)) 
            out_always_comb = 1'b1;
        else
            out_always_comb = 1'b0;
    end
    
    always @(posedge clk)begin
		if((a && !b) || (!a && b)) 
            out_always_ff <= 1'b1;
        else
            out_always_ff <= 1'b0;
    end
endmodule