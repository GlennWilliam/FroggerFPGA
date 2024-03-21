module frog_player2(clock, reset, up, down, left, right, win, RedPixelsPattern, RedPixels, GrnPixels2, enable);
    input logic clock, reset, up, down, left, right, enable;
	 input logic [15:0][15:0] RedPixelsPattern;
	 output logic win;
    output logic [15:0][15:0] GrnPixels2;
	 output logic [15:0][15:0] RedPixels;
	 
	 logic [3:0]y_pos = 3; // 4 bits to represent 0-15 positions
	 logic [4:0] x_pos = 15; // Extra bit for win reset location 
	 logic reStart = 0;

		
    // Update position based on userInput() 
    always_ff@(posedge clock) begin
        if (reset | reStart | win) begin
            // Reset position to the center or a defined start position
            x_pos <= 15;
            y_pos <= 3;
//				reStart <= 0;
				win = 0;
		  
//		  end else if (x_pos == 16) begin 
//				reStart = 1;

		  end else if (x_pos == 0) begin 
				win = 1;
				
        end else begin
            casex ({ up, down, left, right })
                4'b1000: x_pos -= 1;
						
                4'b0100: x_pos += 1;
					 
                4'b0010: y_pos += 1;
					 
                4'b0001: y_pos -= 1;
					 
					 4'b0000: ;
					 
					 // default?					 
            endcase
        end
    end
	 
	 
	 assign reStart = (GrnPixels2[x_pos][y_pos] == RedPixelsPattern[x_pos][y_pos]) | x_pos == 16;
	 

    // Set the GrnPixels output
    always_comb begin
        // Initialize all LEDs to off
        GrnPixels2 = 0;
		  RedPixels = 0;
        // Turn on the LED at the green dot's position
		  if(enable) begin
			  GrnPixels2[x_pos][y_pos] = 1;
			  RedPixels[x_pos][y_pos] = 1;
		  end
    end

endmodule





module frog_player2_tb;

  // Test bench signals
  logic clock, reset, up, down, left, right, enable;
  logic [15:0][15:0] RedPixelsPattern;
  logic win;
  logic [15:0][15:0] GrnPixels2, RedPixels;

  // Instantiate the Unit Under Test (UUT)
  frog_player2 uut (
    .clock(clock),
    .reset(reset),
    .up(up),
    .down(down),
    .left(left),
    .right(right),
    .enable(enable),
    .RedPixelsPattern(RedPixelsPattern),
    .win(win),
    .GrnPixels2(GrnPixels2),
    .RedPixels(RedPixels)
  );

  // Clock generation
  always #5 clock = ~clock;

  initial begin
    clock = 0; 
    reset = 1; 
    up = 0; 
    down = 0; 
    left = 0; 
    right = 0; 
    enable = 1; 
    RedPixelsPattern = 16'b0000_1000_0100_0010;

    #10 reset = 0;
    #20 up = 1; #10 up = 0;
    #20 down = 1; #10 down = 0;
    #20 left = 1; #10 left = 0;
    #20 right = 1; #10 right = 0; 
    #20 enable = 0; 
    #50 $stop;
  end

endmodule

		