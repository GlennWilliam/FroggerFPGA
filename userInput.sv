module userInput(clock, reset, Key, Out);
	input logic clock, reset, Key;
	output logic Out;
	
	logic Key1, Key2;
	
	//MetaStability two flipflops
	always_ff @(posedge clock)
		Key1 <= Key;
	always_ff @(posedge clock)
		Key2 <= Key1;
	
	
	// State variables
	enum { OFF, ON } ps, ns;
	
	// Next State logic
	always_comb begin
		case (ps)
			OFF:	if (Key2) ns = ON;
						else ns = OFF;
			ON:	if (Key2) ns = ON;
					else ns =OFF;
		endcase
	end
	
	// Output logic
	assign Out = (ps == OFF) & (Key2);
	
	// DFFs
	always_ff @(posedge clock) begin
		if (reset)
			ps <= ON;
		else
			ps <= ns;
	end
	
endmodule



module userInput_testbench();
	logic clock, reset, Key;
	logic Out;
	
	userInput dut (clock, reset, Key, Out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
										@(posedge clock);
		reset <= 1; 				@(posedge clock); // Always reset FSMs at start
		reset <= 0; Key <= 0; 	@(posedge clock);
										@(posedge clock);
										@(posedge clock);
										@(posedge clock);
						Key <= 1;	@(posedge clock);
						Key <= 0;	@(posedge clock);
						Key <= 1;	repeat(7)@(posedge clock);
										@(posedge clock);
										@(posedge clock);
										@(posedge clock);
						Key <= 0;	@(posedge clock);
										@(posedge clock);
		$stop; // End the simulation.
	end
endmodule