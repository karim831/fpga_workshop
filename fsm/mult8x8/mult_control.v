module mult_control(
    input clk,arst_n,start,[1:0]count,
    output reg sclr_n,clk_ena,done,[1:0] input_sel,shift_sel,[2:0]state_out
);

    localparam IDLE = 3'b000;
    localparam LSB = 3'b001;
    localparam MID = 3'b010;
    localparam MSP = 3'b011;
    localparam CALC_DONE = 3'b100;
    localparam ERR = 3'b101;

    reg [2:0] current_state = IDLE,next_state;

    always @(posedge clk,negedge arst_n)begin
        if(!arst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*)begin
        input_sel = 2'bxx;
        shift_sel = 2'bxx;
        state_out = 3'bxxx;
        done = 1'b0;
        clk_ena = 1'b0;
        sclr_n = 1'b1;
        next_state = ERR;
        case(current_state)
            IDLE:begin
                if(start)begin
                    clk_ena = 1'b1;
                    sclr_n = 1'b0;
                    next_state = LSB;
                end
                else
                    next_state = IDLE;
            end
            LSB:begin
                if(!start && count == 2'b00)begin
                    input_sel = 2'b00;
                    shift_sel = 2'b00;
                    state_out = count;
                    clk_ena = 1'b1;
                    next_state = MID;
                end
            end
            MID:begin
                if(!start && count == 2'b01)begin
                    input_sel = 2'b01;
                    shift_sel = 2'b01;
                    state_out = count;
                    clk_ena = 1'b1;
                    next_state = MID;
                end
                else if(!start && count == 2'b10)begin
                    input_sel = 2'b10;
                    shift_sel = 2'b01;
                    state_out = count;
                    clk_ena = 1'b1;
                    next_state = MSP;
                end
            end
            MSP:begin
                if(!start && count == 2'b11)begin
                    input_sel = 2'b11;
                    shift_sel = 2'b10;
                    state_out = count;
                    clk_ena = 1'b1;
                    next_state = CALC_DONE;
                end
            end
            CALC_DONE:begin
                if(!start)begin
                    done = 1'b1;
                    next_state = IDLE;
                end
            end
            ERR:begin
                if(start)begin
                    clk_ena = 1'b1;
                    sclr_n = 1'b0;
                    next_state = LSB;
                end
            end
        endcase
    end
endmodule


module mult_control_tb();
    reg clk,arst_n,start;
    reg[1:0] count;

    wire sclr_n,clk_ena,done;
    wire[1:0] input_sel,shift_sel;
    wire[2:0] state_out;


    mult_control DUT(
        .input_sel(input_sel),.shift_sel(shift_sel),.state_out(state_out),
        .sclr_n(sclr_n),.clk_ena(clk_ena),.done(done),
        .clk(clk),.arst_n(arst_n),.start(start),
        .count(count)
    );
    always #100 clk = ~clk; // clock design
    
    initial begin
        /* go to LSP */
        clk <= 1'b0;
        arst_n <= 1'b1; 
        start <= 1'b1;
        #100;
        /* go to MID*/
        start <= 1'b0;
        count <= 2'b00;
        #200;
        /* go to MID again*/
        count <= 2'b01;
        #200;
        /* reset */
        arst_n <= 1'b0;
        #10;
        /* go to LSB */
        arst_n <= 1'b1;
        start <= 1'b1;
        #190;
        /* go to MID */
        start <= 1'b0;
        count <= 2'b00;
        #200;
        /* go to MID again */
        count <= 2'b01;
        #200;
        /* go to MSP */
        count <= 2'b10;
        #200;
        /* go to CALC_DONE*/
        count <= 2'b11;
        #200;
        /*go to IDLE*/
        #200;
        $stop;
    end
endmodule