`timescale 1ns / 1ps

module SafeBox_tb;

	// Inputs
	reg clk;
	reg btn0;
	reg btn1;
	reg btn2;
	reg btn3;
	reg switch;

	// Outputs
	wire [6:0] sevensegs;
	wire [3:0] anodos;
	wire [7:0] leds;

	// Instantiate the Unit Under Test (UUT)
	SafeBox uut (
		.clk(clk), 
		.btn0(btn0), 
		.btn1(btn1), 
		.btn2(btn2), 
		.btn3(btn3), 
		.switch(switch), 
		.sevensegs(sevensegs), 
		.anodos(anodos), 
		.leds(leds)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btn0 = 0;
		btn1 = 0;
		btn2 = 0;
		btn3 = 0;
		switch = 0;
	end
	
	always begin	
		#1 clk = ~clk;
	end
	

	always begin
		#100; 
			btn0 = 0;
			btn1 = 0;
			btn2 = 0;
			btn3 = 1;
			switch = 1;
		#50;			
			btn3 = 0;		
		#100; 
			btn0 = 0;
			btn1 = 0;
			btn2 = 0;
			btn3 = 1;
			switch = 0;
		#10; 			
			btn3 = 0;			
		#100;
			btn0 = 1;			
			btn2 = 0;
		 #1 btn0=0;
		 #1 btn0=1;
		 #1 btn0=0;
		 #1 btn0=1;	
		 #1 btn0=0;	
		#100;
			btn0 = 0;
			btn1 = 0;
			btn2 = 0;
			btn3 = 1;
			switch = 1; 
		 #10;	
				btn3 = 0;
				switch = 0;
		 #1 btn2=1;
		 #1 btn2=0;
		 #1 btn2=1;
		 #1 btn2=0;
		 #100;
			#1 btn1=1;
			#1 btn1=0;
			#1 btn1=1;
			#1 btn1=0;
			#1 btn1=1;
			#1 btn1=0;
		 #100;
			btn0 = 0;
			btn1 = 0;
			btn2 = 0;
			btn3 = 1;
			switch = 1;
		 
		#10000; 
 
//		#100; 
//			btn0 = 0;
//			btn1 = 0;
//			btn2 = 0;
//			btn3 = 0;
//			switch = 0;
//		#1;			
//			btn2 = 1;
//		#1;			
//			btn2 = 0;
//		#1;			
//			btn2 = 1;
//		#1;			
//			btn2 = 0;
//			btn1 = 1;
//		#100;
//			#100; 
//			btn0 = 0;
//			btn1 = 0;
//			btn2 = 0;
//			btn3 = 1;
//			switch = 1;
//		#100;
		
	end 

       
endmodule

