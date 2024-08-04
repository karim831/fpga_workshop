module always_case2 (
    input [3:0] in,
    output reg [1:0] pos  
);
    always @(*)begin
        pos = 2'd0;
        if(in[0])
            pos = 2'd0;
        else if(in[1])
            pos = 2'd1;
        else if(in[2])
            pos = 2'd2;
        else if(in[3])
            pos = 2'd3;
        
    end
endmodule