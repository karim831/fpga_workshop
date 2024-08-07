module piso(
    input arst_n,send,baud_clk,data_length,stop_bits,parity_in,
	 input [1:0]parity_type,
	 input [7:0] data_in,
    output reg tx,parity_out,tx_active,tx_done
);
    localparam IDLE = 3'b000;
    localparam START_BIT = 3'b001;
    localparam DATA_BITS = 3'b010;
    localparam PARITY_BIT = 3'b011;
    localparam STOP1_BIT = 3'b100;
    localparam STOP2_BIT = 3'b101;


    reg[2:0] current_state,next_state;
    reg[2:0] data_count;
	  
	 always @(negedge arst_n , posedge baud_clk) begin
        if (!arst_n) begin
            current_state <= IDLE;
            data_count <= 3'b000;  
        end else begin
            current_state <= next_state;
				
            if (current_state == START_BIT) 
                data_count <= 3'b000; 
				else 
                data_count <= data_count + 1'b1; 
        end
    end

    always @(*)begin
        case(current_state)
            IDLE : begin
                tx = 1'b1;
                parity_out = 1'b0;
                tx_active = 1'b0;
                tx_done = 1'b1;
                next_state = IDLE;
                if(send) 
                    next_state = START_BIT;
            end
            START_BIT : begin
                tx =  1'b0;
                parity_out = 1'b0;
                tx_active = 1'b1;
                tx_done = 1'b0;
                next_state = DATA_BITS;
            end
            DATA_BITS : begin
                tx = data_in[data_count]; 
                if(((data_length) && (data_count == 3'b111)) || ((!data_length) && (data_count == 3'b110)))begin
                    if((^parity_type))
                        next_state = PARITY_BIT;
                    else begin
                        next_state = STOP1_BIT;
                        if(parity_type == 2'b11)
                            parity_out = parity_in;
                    end
                end
            end
            PARITY_BIT : begin 
                tx = parity_in;
                next_state = STOP1_BIT;
            end
            STOP1_BIT : begin 
                tx = 1'b1;
                tx_done = 1'b1;
                tx_active = 1'b0;
                if(stop_bits)
                    next_state = STOP2_BIT;
                else 
                    next_state = IDLE;
            end
            STOP2_BIT : next_state = IDLE;
            default : begin
                tx = 1'b1;
                parity_out = 1'b0;
                tx_active = 1'b0;
                tx_done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule