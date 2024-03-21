module displayWinner (f1, f2, RedPixels, GrnPixels, reset);
	input logic f1, f2, reset;
	output logic [15:0][15:0] RedPixels;
	output logic [15:0][15:0] GrnPixels;
	
	always_comb 
	if(reset) begin
		RedPixels = 0;
		GrnPixels = 0;
	end
	else
	 begin
	 if(f1) begin
		  //                  FEDCBA9876543210
		                      
		  GrnPixels[00] = 16'b0000000110000000;
		  GrnPixels[01] = 16'b0000000110000000;
		  GrnPixels[02] = 16'b0000000110000000;
		  GrnPixels[03] = 16'b0000000110000000;
		  GrnPixels[04] = 16'b0000000110000000;
		  GrnPixels[05] = 16'b0000000110000000;
		  GrnPixels[06] = 16'b0000000110000000;
		  GrnPixels[07] = 16'b0000000110000000;
		  GrnPixels[08] = 16'b0000000110000000;
		  GrnPixels[09] = 16'b0000000110000000;
		  GrnPixels[10] = 16'b0000000110000000;
		  GrnPixels[11] = 16'b0000000110000000;
		  GrnPixels[12] = 16'b0000000110000000;
		  GrnPixels[13] =	16'b0000000110000000;
		  GrnPixels[14] = 16'b0000000110000000;
		  GrnPixels[15] = 16'b0000000110000000;
		  
		  RedPixels = 0;
		end
	
	else if (f2) begin
		  RedPixels[00] = 16'b1111111111111111;
		  RedPixels[01] = 16'b1111111111111111;
		  RedPixels[02] = 16'b0000000000000011;
		  RedPixels[03] = 16'b0000000000000011;
		  RedPixels[04] = 16'b0000000000000011;
		  RedPixels[05] = 16'b0000000000000011;
		  RedPixels[06] = 16'b0000000000000011;
		  RedPixels[07] = 16'b1111111111111111;
		  RedPixels[08] = 16'b1111111111111111;
		  RedPixels[09] = 16'b1100000000000000;
		  RedPixels[10] = 16'b1100000000000000;
		  RedPixels[11] = 16'b1100000000000000;
		  RedPixels[12] = 16'b1100000000000000;
		  RedPixels[13] = 16'b1100000000000000;
		  RedPixels[14] = 16'b1111111111111111;
		  RedPixels[15] = 16'b1111111111111111;
		  
		  //                  FEDCBA9876543210
		  GrnPixels[00] = 16'b1111111111111111;
		  GrnPixels[01] = 16'b1111111111111111;
		  GrnPixels[02] = 16'b0000000000000011;
		  GrnPixels[03] = 16'b0000000000000011;
		  GrnPixels[04] = 16'b0000000000000011;
		  GrnPixels[05] = 16'b0000000000000011;
		  GrnPixels[06] = 16'b0000000000000011;
		  GrnPixels[07] = 16'b1111111111111111;
		  GrnPixels[08] = 16'b1111111111111111;
		  GrnPixels[09] = 16'b1100000000000000;
		  GrnPixels[10] = 16'b1100000000000000;
		  GrnPixels[11] = 16'b1100000000000000;
		  GrnPixels[12] = 16'b1100000000000000;
		  GrnPixels[13] = 16'b1100000000000000;
		  GrnPixels[14] = 16'b1111111111111111;
		  GrnPixels[15] = 16'b1111111111111111; 
		  
		end
	end

	
	
endmodule


module displayWinner_testbench;

  logic f1_tb, f2_tb, reset_tb;
  logic [15:0][15:0] RedPixels_tb, GrnPixels_tb;

  displayWinner uut (
    .f1(f1_tb), 
    .f2(f2_tb), 
    .RedPixels(RedPixels_tb), 
    .GrnPixels(GrnPixels_tb), 
    .reset(reset_tb)
  );

  initial begin
    f1_tb = 0; 
    f2_tb = 0; 
    reset_tb = 1;

    #10 reset_tb = 0;
    #10 f1_tb = 1; f2_tb = 0;
    #10 f1_tb = 0;
    #20 f1_tb = 0; f2_tb = 1;
    #10 f2_tb = 0;
    #20 f1_tb = 1; f2_tb = 1;
    #10 f1_tb = 0; f2_tb = 0;
    #20 reset_tb = 1;
    #10 reset_tb = 0;
    #30 $stop;
  end


endmodule
