module Connection_ports_by_position ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a test(out1,out2,a,b,c,d);
endmodule
