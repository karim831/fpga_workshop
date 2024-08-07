module frame_gen(
    input data_w,parity_w,frame_gen,data_length,parity_in,
    input [7:0]data_in, 
    output [7:0] data_out,
    output reg [11:0] frame_out
);
    reg[11:0] frame;

    assign data_out = frame[8:1];

    always @(posedge data_w)begin
        if(data_length)
            frame[8:1] <= data_in; 
        else
            frame[8:1] <= {1'b0,data_in[6:0]};
    end

    always @(posedge parity_w)begin
        frame[9] <= parity_in;
    end

    always @(posedge frame_gen)begin
        frame[0] <= 1'b0;
        frame[11:10] <= 2'b11;
        frame_out <= frame;
    end

endmodule


module frame_gen_tb();
    reg data_w,parity_w,frame_gen,data_length;
    reg [7:0]data_in;
    wire parity_in;
    wire [7:0] data_out;
    wire [11:0] frame_out;


    frame_gen DUT(
        .frame_out(frame_out),.data_out(data_out),
        .data_in(data_in),.parity_in(parity_in),.data_length(data_length),
        .frame_gen(frame_gen),.parity_w(parity_w),.data_w(data_w)
    );

    assign parity_in = (^data_out);
    initial begin
        data_in <= $random;
        #100;
        data_w <= 1'b1;
        #100;
        data_w <= 1'b0;
        parity_w <= 1'b1;
        #100;
        parity_w <= 1'b0;
        frame_gen <= 1'b1;
        #100;
        $stop;
    end
endmodule