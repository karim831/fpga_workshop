module shifter(
    input [7:0]inp,[1:0]shift_ctrl,
    output reg [15:0]shift_out
);

    always @(*)begin
        shift_out = {{8{1'd0}},inp};
        case(shift_ctrl)
            2'b01 : shift_out = {{8{1'd0}},inp}<<4;
            2'b10 : shift_out = {{8{1'd0}},inp}<<8;
        endcase
    end
endmodule


module shifter_tb();
    integer i;
    reg[7:0] inp;
    reg[1:0] shift_ctrl;
    wire[15:0] shift_out;

    shifter DUT(.shift_out(shift_out),.inp(inp),.shift_ctrl(shift_ctrl));

    initial begin
        inp = 8'd0;
        shift_ctrl = 2'd0;
        #100;

        for(i = 0;i <5 ;i = i+1)begin
            inp = $random;
            shift_ctrl = $random;
            #100;
        end
        $stop;
    end

    initial $monitor("time = %t, input = %b, shift_ctrl = %b, shift_out = %b",$time,inp,shift_ctrl,shift_out);
endmodule