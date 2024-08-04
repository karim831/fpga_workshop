module mult8x8(
    input start,arst_n,clk,[7:0] dataa,datab,
    output done_flag,seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g,[15:0]product8x8_out
);
    wire[3:0] aout,bout;

    wire[1:0] sel,shift,count;
    wire[2:0] state_out;
    wire clk_ena,sclr_n; 

    wire [7:0] product;
    wire [15:0] shift_out,sum;

    mux4 muxa(.mux_out(aout),.mux_in_a(dataa[3:0]),.mux_in_b(dataa[7:4]),.mux_sel(sel[1]));
    mux4 muxb(.mux_out(bout),.mux_in_a(datab[3:0]),.mux_in_b(datab[7:4]),.mux_sel(sel[0]));

    mult_control ctrl(.input_sel(sel),.shift_sel(shift),.state_out(state_out),
        .done(done_flag),.clk_ena(clk_ena),.sclr_n(sclr_n),
        .clk(clk),.arst_n(arst_n),.start(start),.count(count)
    );

    counter ctr(.count_out(count),.clk(clk),.aclr_n(!start));

    mult4x4 mult(.product(product),.dataa(aout),.datab(bout));

    shifter shft(.shift_out(shift_out),.inp(product),.shift_ctrl(shift));

    adder16 addr(.sum(sum),.dataa(shift_out),.datab(product8x8_out));

    reg16 rgstr(.data_out(product8x8_out),.clk(clk),.sclr_n(sclr_n),.clk_ena(clk_ena),.data_in(sum));

    seven_segement_contorller seven_ctrl(.seg_a(seg_a),.seg_b(seg_b),.seg_c(seg_c),.seg_d(seg_d),
        .seg_e(seg_e),.seg_f(seg_f),.seg_g(seg_g),
        .inp(state_out)
    );

endmodule


module mult8x8_tb();
    wire done_flag,seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g;
    wire[15:0] product8x8_out;

    reg start,arst_n,clk;
    reg[7:0] dataa,datab;


    mult8x8 mult(
        .done_flag(done_flag),.seg_a(seg_a),.seg_b(seg_b),
        .seg_c(seg_c),.seg_d(seg_d),.seg_e(seg_e),.seg_f(seg_f),.seg_g(seg_g),.product8x8_out(product8x8_out),
        .start(start),.arst_n(arst_n),.clk(clk),
        .dataa(dataa),.datab(datab)
    );
    always #100 clk = ~clk;

    initial begin
        clk <= 1'b0;
        arst_n <= 1'b1;
        start <= 1'b1;
        dataa <= 8'd100;
        datab <= 8'd200;
        #100;
        start <= 1'b0;
        #1000;
        $stop;
    end


endmodule