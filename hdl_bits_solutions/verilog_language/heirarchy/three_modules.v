module three_modules ( input clk, input d, output q );
    wire q1,q2;
    my_dff dff1(.q(q1),.clk(clk),.d(d));
    my_dff dff2(.q(q2),.clk(clk),.d(q1));
	my_dff dff3(.q(q),.clk(clk),.d(q2));
	
        
endmodule