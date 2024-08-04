module adder2 (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1,cout2;
    add16 lower_adder(.sum(sum[15:0]),.cout(cout1),.a(a[15:0]),.b(b[15:0]),.cin(0));
    add16 upper_adder(.sum(sum[31:16]),.cout(cout2),.a(a[31:16]),.b(b[31:16]),.cin(cout1));

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

	assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (a&cin) | (b&cin);

endmodule