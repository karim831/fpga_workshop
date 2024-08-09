module baud_generator #(
    parameter FREQ = 50e6 // 50 MHZ clock
)(
    input clk,arst_n,
	 input [1:0]baud_rate,
    output reg baud_out    
);

parameter BAUD_2400 = 2400;
parameter BAUD_4800 = 4800;
parameter BAUD_9600 = 9600;
parameter BAUD_19200 = 19200;


localparam [15:0] COUNTS_2400 = (FREQ/(2*BAUD_2400));
localparam [15:0] COUNTS_4800 = (FREQ/(2*BAUD_4800));  
localparam [15:0] COUNTS_9600 = (FREQ/(2*BAUD_9600));
localparam [15:0] COUNTS_19200 = (FREQ/(2*BAUD_19200));


reg[15:0] max_counts;
reg[15:0] counter;

always @(*)begin
    max_counts = COUNTS_2400;
    case(baud_rate)
        2'b00 : max_counts = COUNTS_2400;
        2'b01 : max_counts = COUNTS_4800;
        2'b10 : max_counts = COUNTS_9600;
        2'b11 : max_counts = COUNTS_19200;
    endcase
end

always @(posedge clk,negedge arst_n)begin
    if(!arst_n)begin
        baud_out = 1'b0;
        counter = {16{1'b0}};
    end
    else begin 
        if(counter >= max_counts)begin
            counter <= {16{1'b0}};
            baud_out <= ~baud_out;
        end
        else
            counter <=  counter + {{15{1'b0}},1'b1};    
    end
end
endmodule

`timescale 1ns / 1ns
module baud_generator_tb();
    integer i;
    reg clk;
    reg arst_n = 1'b0;
    reg[1:0] baud_rate;
    wire baud_out;

    baud_rateerator #(.FREQ(50e6)) DUT(.baud_out(baud_out),.clk(clk),.arst_n(arst_n),.baud_rate(baud_rate));

    always #10 clk = ~clk;  
    initial begin
        clk <= 1'b0;
        arst_n <= 1'b1;
        baud_rate <= 2'b10;
        for(i = 0;i<20;i = i+1)begin
        #52100; // complete baud_rate
        $display("$time = %t, clk = %b,arst_n = %b, baud_rate = %b, baud_out = %b",$time,clk,arst_n,baud_rate,baud_out);
        end
        $stop;
    end
endmodule   