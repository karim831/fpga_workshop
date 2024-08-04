module counter(
    input clk,aclr_n,
    output [1:0]count_out
);
    reg [1:0]tmp = 2'b00;
    assign count_out = tmp;
    always @(posedge clk,negedge aclr_n)begin
        if(!aclr_n)
            tmp <= 2'b00;
        else
            tmp <= tmp + 2'b01; 
    end
endmodule

module counter_tb();
    reg clk,aclr_n;
    wire [1:0]count_out;

    counter DUT(.count_out(count_out),.clk(clk),.aclr_n(aclr_n));

    always #100 clk = ~clk; 
    initial begin
        clk = 1'b0;
        aclr_n = 1'b1;
        #600;
        aclr_n = 1'b0;
        #200;
        $stop;
    end
    initial $monitor("time = %t, clk = %b, aclr_n = %b, count_out = %b",$time,clk,aclr_n,count_out);
endmodule