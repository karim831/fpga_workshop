module adder16(
    input [15:0] dataa,datab,
    output [15:0] sum
);
    assign sum = dataa + datab;
endmodule


module adder16_tb();
integer i;
reg [15:0] dataa,datab;
wire [15:0] sum; 

adder16 DUT(.sum(sum),.dataa(dataa),.datab(datab));


initial begin
    dataa = 16'd0;
    datab = 16'd0;
    #100;
    for(i = 0;i<5;i = i+1)begin
        dataa = $random;
        datab = $random;
        #100;
    end
    $stop;
end

initial $monitor("time = %t ,dataa = %d ,datab = %d ,sum = %d",$time,dataa,datab,sum);
endmodule