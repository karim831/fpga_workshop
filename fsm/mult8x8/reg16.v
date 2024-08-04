module reg16(
    input clk,sclr_n,clk_ena,[15:0]data_in,
    output reg[15:0]data_out
);

    always @(posedge clk)begin
        if(clk_ena)begin
            if(!sclr_n)
                data_out <= 16'd0;
            else
                data_out <= data_in;
        end
    end
endmodule


module reg16_tb();
    integer i;
    reg[15:0] data_in;
    reg clk,sclr_n,clk_ena;
    wire [15:0]data_out;

    reg16 DUT(.data_out(data_out),.clk(clk),.sclr_n(sclr_n),.clk_ena(clk_ena),.data_in(data_in));

    always #100 clk <= ~clk;
    initial begin
        data_in = 16'd0;
        clk = 1'b0;
        sclr_n = 1'b0;
        clk_ena = 1'b0;
        #100;
        for(i = 0;i < 15;i = i+1)begin
            data_in = $random;
            sclr_n = $random;
            clk_ena = $random;
            #100;
        end
        $stop;
    end
    initial $monitor("time = %t, data_in = %b, clk = %b, sclr_n = %b, clk_ena = %b, data_out = %b",
        $time,data_in,clk,sclr_n,clk_ena,data_out
    );
endmodule