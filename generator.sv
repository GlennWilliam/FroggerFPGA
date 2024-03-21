//Creates random number
module generator (clock, reset, out);
    input logic clock, reset;
    output logic [15:0] out;

    logic feedback;
    assign feedback = ~(out[15] ^ out[14] ^ out[12] ^ out[3]);
    always @(posedge clock) begin
        if(reset)
            out <= 16'b0000000000000000;
        else
            out <= {feedback, out[15:1]};
    end

endmodule




module generator_testbench;
    logic clock, reset;
    logic [15:0]out;

    LFSR uut (clock, Reset, out);

    parameter CLOCK_PERIOD = 100;
    initial begin
        clock <= 0;
        forever #(CLOCK_PERIOD/2) clock <= ~clock; // Forever toggle the clock
    end
 
	initial begin
		Reset <= 1;
		repeat(2) @(posedge clock);

		Reset <= 0;		repeat(10) @(posedge clock);
		Reset <= 1;		repeat(3) @(posedge clock);
		Reset <= 0;		repeat(10) @(posedge clock);
		Reset <= 1;		repeat(2) @(posedge clock);

		
		$stop;
		
	end

endmodule