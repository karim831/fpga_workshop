module parity(
    input data_length,
	 input [1:0]parity_type,
	 input [7:0]data_in,
    output reg parity_out
);

always @(*)begin
    parity_out = 1'b0;
    casex(parity_type)
        2'bx1 : parity_out = data_length ? ~(^data_in) : ~(^data_in[6:0]);
        2'b10 : parity_out = data_length ? (^data_in) : (^data_in[6:0]);
    endcase    
end
endmodule
