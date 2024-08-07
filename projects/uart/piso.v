module piso(
    input arst_n,send,baud_clk,data_length,stop_bits,parity_in,[1:0]parity_type,[11:0] frame_in,
    output reg tx,parity_out,tx_active,tx_done
);
    localparam IDLE = 3'b000;
    localparam START_BIT = 3'b001;
    localparam DATA_BITS = 3'b010;
    localparam PARITY_BIT = 3'b011;
    localparam STOP1_BIT = 3'b100;
    localparam STOP2_BIT = 3'b101;


    reg[2:0] current_state,next_state;
    reg[3:0] data_count;


    always @(negedge arst_n,posedge baud_clk)begin
        if(!arst_n)begin
            current_state <= IDLE;
            data_count <= 4'b0001;
        end
        else
            current_state <= next_state;
    end


    always @(*)begin
        case(current_state)
            IDLE : begin
                tx = 1'b1;
                parity_out = 1'b0;
                tx_active = 1'b0;
                tx_done = 1'b0;
                next_state = IDLE;
                if(send)
                    next_state = START_BIT;
            end
            START_BIT : begin
                tx =  frame_in[0];
                tx_active = 1'b1;
                data_count = 4'b0001;
                next_state = DATA_BITS;
            end
            DATA_BITS : begin
                tx = frame_in[data_count]; 
                if((data_length && data_count == 4'b1000) || (!data_length && data_count == 4'b0111))begin
                    if((^parity_type))
                        next_state = PARITY_BIT;
                    else begin
                        next_state = STOP1_BIT;
                        if(parity_type == 2'b11)
                            parity_out = parity_in;
                    end
                end
                else 
                    data_count = data_count + 1;
            end
            PARITY_BIT : begin 
                tx = frame_in[9];
                next_state = STOP1_BIT;
            end
            STOP1_BIT : begin 
                tx = frame_in[10];
                if(stop_bits)
                    next_state = STOP2_BIT;
                else begin
                    if(send)
                        next_state = START_BIT;
                    else
                        next_state = IDLE;
                    tx_done = 1'b1;
                    tx_active = 1'b0;
                end
            end
            STOP2_BIT : begin 
                tx = frame_in[11];
                tx_done = 1'b1;
                tx_active = 1'b0;
                if(send)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            default : begin
                tx = 1'b1;
                parity_out = 1'b0;
                tx_active = 1'b0;
                tx_done = 1'b0;
                next_state = IDLE;
            end
        endcase
    end
endmodule


module piso_tb();
    integer i;
    reg arst_n,send,baud_clk,data_length,stop_bits,parity_in;
    reg[1:0] parity_type;
    reg[11:0] frame_in;
    wire tx,parity_out,tx_active,tx_done;


    piso DUT(
        .tx(tx),.parity_out(parity_out),.tx_active(tx_active),.tx_done(tx_done),
        .frame_in(frame_in),.parity_type(parity_type),
        .arst_n(arst_n),.send(send),.baud_clk(baud_clk),
        .data_length(data_length),.stop_bits(stop_bits),
        .parity_in(parity_in)
    );

    always #100 baud_clk = ~baud_clk;

    initial begin
        arst_n <= 1'b0;
        data_length <= 1'b1;
        stop_bits <= 1'b1;
        parity_in <= 1'b1;
        parity_type <= 2'b10;
        frame_in <= 12'b11_0_11001110_0;
        #100;
        arst_n <= 1'b1;
        send <= 1'b1;
        for(i = 0;i<5;i=i+1)
            #200;
        $stop;
    end
endmodule