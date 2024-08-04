module declaring_wires(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   
); 
	wire a_and_b,c_and_d,or_out;
    assign a_and_b = a & b;
    assign c_and_d = c & d;
    assign or_out = a_and_b | c_and_d;
    
    assign out = or_out;
    assign out_n = ~or_out;
    
endmodule