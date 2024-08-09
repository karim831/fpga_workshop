module reg8(
    input write_d,arst_n,data_length,
    input [7:0]data_in, 
    output reg [7:0] data_out
);
    always @(negedge arst_n ,posedge write_d) begin
        if(!arst_n) 
            data_out <= {8{1'b0}};
        else
            data_out <= {(data_in[7] & data_length),data_in[6:0]};
    end
endmodule

