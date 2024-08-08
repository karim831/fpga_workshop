module parity(
    input data_length,[1:0]parity_type,[7:0]data_in,
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

module parity_tb();
    integer i;
    reg data_length;
    reg [1:0] parity_type;
    reg[7:0] data_in;
    wire parity_out;

    parity DUT(.parity_out(parity_out),.data_in(data_in),.parity_type(parity_type),.data_length(data_length));

    initial begin
        for(i=0;i<10;i = i+1)begin
            data_length <= $random;
            parity_type <= $random;
            data_in <= $random;
            #100;
        end
        $stop;
    end
endmodule