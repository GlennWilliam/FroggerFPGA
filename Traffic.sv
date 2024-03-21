module Traffic (clock, reset, randomNumber, RedPixels);
    input logic clock, reset, randomNumber;
    output logic [15:0] RedPixels;
	 
	 
    always_ff @(posedge clock) begin
        if (reset) begin
            RedPixels <= 16'b0000_0000_0000_0000; // Initialize with only the first LED on
        end else begin
            if (randomNumber == 1) begin
                RedPixels[0] <= 1;
                     RedPixels <= {RedPixels[14:0], 1'b1}; // Shift the pixels left by 1
            end else begin
                RedPixels[0] <= 0;
                     RedPixels <= {RedPixels[14:0], 1'b0}; // Shift the pixels left by 1
            end

        end
    end

endmodule





module Traffic_tb;

  logic clock_tb, reset_tb, randomNumber_tb;
  logic [15:0] RedPixels_tb;

  Traffic uut (
    .clock(clock_tb),
    .reset(reset_tb),
    .randomNumber(randomNumber_tb),
    .RedPixels(RedPixels_tb)
  );

    parameter CLOCK_PERIOD = 100;
    initial begin
        clock_tb <= 0;
        forever #(CLOCK_PERIOD/2) clock_tb <= ~clock_tb; // Forever toggle the clock
    end

  initial begin
    clock_tb = 0;
    reset_tb = 1;
    randomNumber_tb = 0;

    #10 reset_tb = 0;
    #10 randomNumber_tb = 1;
    #10 randomNumber_tb = 0;
    #10 randomNumber_tb = 1;
    #10 randomNumber_tb = 0;
    #50 reset_tb = 1;
    #10 reset_tb = 0;
	 #30 $stop;
  end

endmodule



