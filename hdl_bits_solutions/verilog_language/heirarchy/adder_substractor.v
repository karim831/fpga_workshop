module adder_substractor(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout;
    add16 lower(.sum(sum[15:0]),.cout(cout),.a(a[15:0]),.b(b[15:0] ^ {16{sub}}),.cin(sub));
    add16 upper(.sum(sum[31:16]),.cout(),.a(a[31:16]),.b(b[31:16] ^ {16{sub}}),.cin(cout));

endmodule
