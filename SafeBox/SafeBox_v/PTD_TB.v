`timescale 1ns / 1ps

module PTD_TB;

	// Inputs
	reg clk;
	reg pulse;

	// Outputs
	wire pulse_out;

	// Instantiate the Unit Under Test (UUT)
	PTD uut (
		.clk(clk), 
		.pulse(pulse), 
		.pulse_out(pulse_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		pulse = 0;		

	end
	
	always begin
		#1 clk = ~clk;
	end
      
	always begin
		#100 pulse = 1;
		#100 pulse = 0;
	end
	
	
endmodule

