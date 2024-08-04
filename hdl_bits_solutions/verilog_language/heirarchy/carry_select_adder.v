module carry_selected_adder(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout;
    wire[15:0] sum1,sum2;
    add16 selector(.sum(sum[15:0]),.cout(cout),.a(a[15:0]),.b(b[15:0]),.cin(0));
    add16 selected1(.sum(sum1),.cout(),.a(a[31:16]),.b(b[31:16]),.cin(0));
    add16 selected2(.sum(sum2),.cout(),.a(a[31:16]),.b(b[31:16]),.cin(1));
    assign sum[31:16] = cout ? sum2 : sum1;

endmodule