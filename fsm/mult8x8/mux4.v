module mux4 (
    input mux_sel,[3:0]mux_in_a,mux_in_b,
    output[3:0] mux_out
);  
    assign mux_out = !mux_sel ? mux_in_a : mux_in_b;
endmodule


module mux4_tb();
    integer i;
    reg mux_sel;
    reg[3:0] mux_in_a,mux_in_b;
    wire[3:0] mux_out;

    mux4 DUT(.mux_out(mux_out),.mux_in_a(mux_in_a),.mux_in_b(mux_in_b),.mux_sel(mux_sel));

    initial begin
        mux_sel = 0;
        mux_in_a = 0;
        mux_in_b = 0;
        #100;
        for(i = 0;i < 5;i = i+1)begin
            mux_sel = $random;
            mux_in_a = $random;
            mux_in_b = $random;
            #100;
        end
        $stop;
    end
    
    initial $monitor("time = %t ,mux_in_a = %d ,mux_in_b = %d ,mux_sel = %d ,mux_out = %d",$time,mux_in_a,mux_in_b,mux_sel,mux_out);
endmodule