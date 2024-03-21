// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
	output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
	input  logic [3:0]  KEY;
	input  logic [9:0]  SW;
	output logic [35:0] GPIO_1;
	input logic CLOCK_50;

	// Turn off HEX displays
	//assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	//assign HEX5 = '1;


	/* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	 ===========================================================*/
	logic [31:0] clk;
	logic SYSTEM_CLOCK;
	logic SYSTEM_CLOCK2;

	clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));

	assign SYSTEM_CLOCK = clk[10]; //14 = 1526 Hz clock signal
	assign SYSTEM_CLOCK2 = clk[24];

	/* If you notice flickering, set SYSTEM_CLOCK faster.
	 However, this may reduce the brightness of the LED board. */


	/* Set up LED board driver
	 ================================================================== */
	logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
	logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	logic RST;                   // reset - toggle this on startup

	assign RST = SW[9];
	logic clock, reset;
	assign clock = SYSTEM_CLOCK;
	assign reset = RST;

	/* Standard LED Driver instantiation - set once and 'forget it'. 
	 See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels(RedPixels | RedPixels2 | RedPixels3), .GrnPixels(GrnPixels | GrnPixels2 | GrnPixels3), .GPIO_1);


	/* LED board test submodule - paints the board with a static pattern.
	 Replace with your own code driving RedPixels and GrnPixels.
	 
	KEY0      : Reset
	=================================================================== */
	logic U1, L1, U2, L2, R, D, W1, W2, f1, f2;
	logic [3:0] sc1, sc2;
	logic [15:0][15:0]GrnPixels2;
	logic [15:0][15:0]RedPixels2;
	logic [15:0][15:0]GrnPixels3;
	logic [15:0][15:0]RedPixels3;
	
	
	// 1 player frog uses 4 buttons
	// 2 player each frog gets 2 buttons 
	userInput f1u (.clock, .reset, .Key(~KEY[3]), .Out(L1));
	userInput f1L (.clock, .reset, .Key(~KEY[2]), .Out(U1));
	userInput f2u (.clock, .reset, .Key(~KEY[1]), .Out(L2));
	userInput f2L(.clock, .reset, .Key(~KEY[0]), .Out(U2));
	
	frog_player1 frog1(.clock, .reset, .up(U1), .down(L2 & ~SW[0]), .left(L1), .right(U2 & ~SW[0]), .win(W1), .RedPixels, .GrnPixels, .enable(~(f1^f2)));
	frog_player2 frog2(.clock, .reset, .up(U2), .down(D), .left(L2), .right(R), .win(W2), .RedPixelsPattern(RedPixels),
		.RedPixels(RedPixels2), .GrnPixels2, .enable((SW[0]) & ( ~(f1 ^ f2))));
	
	scoreKeeper2 s1(.Clock(clock), .Reset(reset), .count(W1), .Display(sc1), .freeze(f1));
	scoreKeeper2 s2(.Clock(clock), .Reset(reset), .count(W2), .Display(sc2), .freeze(f2));
	
	SevenSegment p1( .hexDigit(sc1), .enable(1), .segments(HEX5));
	SevenSegment p2( .hexDigit(sc2), .enable(1), .segments(HEX0));
	
	displayWinner winnerdisplay (.f1(f1), .f2(f2), .RedPixels(RedPixels3), .GrnPixels(GrnPixels3), .reset(RST));
	
	logic[15:0] randomNum;
	logic[15:0] ran2;
	
	generator randomNumber (.clock(SYSTEM_CLOCK), .reset(RST), .out(randomNum));
	generator randomNumber2 (.clock(SYSTEM_CLOCK), .reset(RST), .out(ran2));
//	Zeros (.clock, .reset, .z(Z));
	
//	Traffic traffic0 (.clock(SYSTEM_CLOCK2), .reset(RST), .randomNumber(randomNum[0]), .RedPixels(RedPixels[0])); 
//	Traffic traffic1 (.clock(SYSTEM_CLOCK2), .reset(RST), .randomNumber(randomNum[1]), .RedPixels(RedPixels[1])); 
	Traffic traffic2 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[2] & ran2[3]), .RedPixels(RedPixels[2])); 
	Traffic traffic3 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[3] & ran2[8]), .RedPixels(RedPixels[3])); 
	Traffic traffic4 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[4] & ran2[6]), .RedPixels(RedPixels[4])); 
	Traffic traffic5 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[5] & ran2[3]), .RedPixels(RedPixels[5])); 
	Traffic traffic6 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[6] & ran2[1]), .RedPixels(RedPixels[6])); 
	Traffic traffic7 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[7] & ran2[2]), .RedPixels(RedPixels[7])); 
	Traffic traffic8 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[9] & ran2[2]), .RedPixels(RedPixels[8])); 
	Traffic traffic9 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[9] & ran2[13]), .RedPixels(RedPixels[9])); 
	Traffic traffic10 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[10] & ran2[13]), .RedPixels(RedPixels[10])); 
	Traffic traffic11 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[11] & ran2[10]), .RedPixels(RedPixels[11])); 
	Traffic traffic12 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[12] & ran2[9]), .RedPixels(RedPixels[12])); 
	Traffic traffic13 (.clock(SYSTEM_CLOCK2), .reset(RST | f1 | f2), .randomNumber(randomNum[13] & ran2[15]), .RedPixels(RedPixels[13])); 
//	Traffic traffic14 (.clock(SYSTEM_CLOCK2), .reset(RST), .randomNumber(randomNum[14]), .RedPixels(RedPixels[14])); 
//	Traffic traffic15 (.clock(SYSTEM_CLOCK2), .reset(RST), .randomNumber(randomNum[15]), .RedPixels(RedPixels[15]));	 
endmodule