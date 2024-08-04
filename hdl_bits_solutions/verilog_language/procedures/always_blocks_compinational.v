module always_blocks_compinational(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);
    
    assign out_assign = a & b;
    always @(*)begin
        if(!a || !b)
            out_alwaysblock = 1'b0;
        else
            out_alwaysblock = 1'b1;
    end

endmodule
