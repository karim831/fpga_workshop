module seven_segement_contorller(
    input [2:0]inp,
    output reg seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g
);

    always @(*)begin
        {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1001111;
        case(inp)
            3'b000 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1111110;
            3'b001 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b0110000;
            3'b010 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1101101;
            3'b011 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1111001;
        endcase
    end
endmodule


module seven_segement_contorller_tb();
    integer i;
    reg[2:0] inp;
    wire seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g;

    seven_segement_contorller DUT(.seg_a(seg_a),.seg_b(seg_b),.seg_c(seg_c),.seg_d(seg_d),
        .seg_e(seg_e),.seg_f(seg_f),.seg_g(seg_g),.inp(inp)
    );

    initial begin
        inp = 3'd0;
        #100;
        for(i = 0;i < 5;i = i+1)begin
            inp = $random;
            #100;
        end
        $stop;
    end

    initial $monitor("time = $t, input = %b, output = %b",inp,{seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g});
endmodule
