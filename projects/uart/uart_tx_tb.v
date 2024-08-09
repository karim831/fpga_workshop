`timescale 10ns / 10ns
module uart_tx_tb();
    integer i;
    reg clk,arst_n,send,stop_bits,data_length;
    reg [1:0] baud_rate,parity_type;
    reg [7:0] data_in;
    wire tx,parity_out,tx_active,tx_done;

    
    uart_tx DUT(
        .tx(tx),.parity_out(parity_out),.tx_active(tx_active),.tx_done(tx_done),
        .data_in(data_in),.baud_rate(baud_rate),.parity_type(parity_type),
        .clk(clk),.arst_n(arst_n),.send(send),.stop_bits(stop_bits),.data_length(data_length)
    );


    always #1 clk <= ~clk;

    initial begin
        arst_n <= 1'b0;
        clk <= 1'b0;
        baud_rate <= 2'b10;
        stop_bits <= 1'b1;
        data_length <= 1'b1;
        parity_type <= 2'b10;
        #5210;
        send <= 1'b1;
        arst_n <= 1'b1;
        data_in <= 8'b1101_0101;
        for(i = 0;i < 24;i = i+1)begin
            #5210;
        end
        baud_rate <= 2'b01;
        stop_bits <= 1'b0;
        data_length <= 1'b0;
        parity_type <= 2'b11;
        data_in <= 8'b1101_0101;
        for(i = 0;i < 24 ;i = i+1)
            #10420;
        $stop;
    end
endmodule