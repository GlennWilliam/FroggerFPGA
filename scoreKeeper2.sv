module scoreKeeper2 (Clock, Reset, count, Display, freeze);
	input logic Clock, Reset, count;
	output logic [3:0]Display;
	output logic freeze;
	
	logic [3:0] tPoints = 4'b0000;

	always_ff @(posedge Clock) begin
		if (Reset) begin
			tPoints = 4'b0000;
			freeze = 0;
			end
		else if (tPoints == 4'b0011) begin 
			tPoints = 4'b0011;
			freeze = 1;
			end
		else if (count)
			tPoints += 1;
		else;
	end	
	
	
	//Output 	
	assign Display = tPoints; //NOT SHOWING UP ON THE SIM BUT WORKS ON THE BOARD 	
	
endmodule 




module scoreKeeper2_testbench;
    logic Clock, Reset, count;
    logic [3:0]Display;

    scoreKeeper dut (Clock, Reset, count, Display);

    parameter CLOCK_PERIOD = 100;
    initial begin
        Clock <= 0;
        forever #(CLOCK_PERIOD/2) Clock <= ~Clock; // Forever toggle the clock
    end
 
	initial begin
		Reset <= 1; count <= 0;
		repeat(2) @(posedge Clock);

		Reset <= 0;		repeat(1) @(posedge Clock);
		count <= 1;		repeat(1) @(posedge Clock);
		count <= 0;		repeat(1) @(posedge Clock);
		count <= 1;		repeat(3) @(posedge Clock);
		count <= 0;		repeat(1) @(posedge Clock);
		count <= 1;		repeat(1) @(posedge Clock);
		count <= 0;		repeat(1) @(posedge Clock);
		
		Reset <= 1;		repeat(2) @(posedge Clock);
		Reset <= 0;		repeat(1) @(posedge Clock);
		count <= 1;		repeat(1) @(posedge Clock);
		count <= 0;		repeat(1) @(posedge Clock);
		count <= 1;		repeat(1) @(posedge Clock);
		count <= 0;		repeat(1) @(posedge Clock);
		count <= 1;		repeat(1) @(posedge Clock);
		count <= 0;		repeat(1) @(posedge Clock);
		
		$stop;
		
	end

endmodule