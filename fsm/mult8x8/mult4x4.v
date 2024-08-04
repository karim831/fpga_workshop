module mult4x4(
    input[3:0] dataa,datab,
    output[7:0] product
);

assign product = dataa * datab;
endmodule


module mult4x4_tb();
    integer i;
    reg[3:0] dataa,datab;
    wire[7:0] product;

    mult4x4 DUT(.product(product),.dataa(dataa),.datab(datab));

    initial begin
        dataa = 4'd0;
        datab = 4'd0;
        #100;
        for(i = 0;i<5;i = i+1)begin
            dataa = $random;
            datab = $random;
            #100;
        end
        $stop;
    end

    initial $monitor("time = %t ,dataa = %d ,datab = %d ,product = %d",$time,dataa,datab,product);
endmodule