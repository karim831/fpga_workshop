module reg8(
    input write_d,arst_n,data_length,
    input [7:0]data_in, 
    output reg [7:0] data_out
);
    always @(negedge arst_n ,posedge write_d) begin
        if(!arst_n) 
            data_out <= {8{1'b0}};
        else
            data_out <= {(data_in[7] & data_length),data_in[6:0]};
    end
endmodule


module reg8_tb();
    reg write_d,arst_n,data_length;
    reg [7:0]data_in;
    wire [7:0] data_out;


    reg8 DUT(
        .data_out(data_out),.data_in(data_in),.data_length(data_length),
        .arst_n(arst_n),.write_d(write_d)
    );

    always #100 write_d = ~write_d;
    initial begin
        write_d <= 1'b0;
        arst_n <= 1'b0;
        data_length <= 1'b1;
        data_in <= 8'hFF;
        #10;
        arst_n <= 1'b1;
        #90;
        data_length <= 1'b0;
        #300;   
        $stop;
    end
endmodule