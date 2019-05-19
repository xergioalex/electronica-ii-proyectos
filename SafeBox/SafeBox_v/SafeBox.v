`timescale 1ns / 1ps

//Caja de Seguridad
module SafeBox(clk, btn0,btn1,btn2,btn3,switch,sevensegs,anodos,leds);
    input clk,btn0,btn1,btn2,btn3,switch;    
    output [6:0] sevensegs;
    output [3:0] anodos;
    output [7:0] leds;    
	 wire pulse0,pulse1,pulse2,pulse3;
	 wire en0,en1,en2,en3;
	 wire [15:0] clave;
	 wire [3:0] clave0,clave1,clave2,clave3;
	 wire clk_display;
	 
	 Divisor divisor_display(clk,clk_display);
	 PTD push_button0(clk,btn0,pulse0);
	 PTD push_button1(clk,btn1,pulse1);
	 PTD push_button2(clk,btn2,pulse2);
	 PTD push_button3(clk,btn3,pulse3);
	 Decodificador Dec_Anodos(pulse2, en0,en1,en2,en3);
	 Registro R_Clave0(clk, pulse0 && en0,pulse1 && en0,clave0);
	 Registro R_Clave1(clk, pulse0 && en1,pulse1 && en1,clave1);
	 Registro R_Clave2(clk, pulse0 && en2,pulse1 && en2,clave2);
	 Registro R_Clave3(clk, pulse0 && en3,pulse1 && en3,clave3);
	 Display Segmentos(clk_display, clave, sevensegs,anodos);
	 Update_And_Check ActualizarVerificar(clave, pulse3,switch,leds);
	 
	 assign clave = {clave0,clave1,clave2,clave3};
	
endmodule

// MODULO: Registro clave de 4 bits
module Registro(clk, en_sub , en_add , clave);
	input clk,en_add,en_sub;	
	output reg [3:0] clave;
		
	initial clave = 4'b0;
 
	always @ (posedge clk)begin							
		if(en_add)
			clave <= (clave==4'b1001)? 4'b0 : clave+4'b0001;
		else if(en_sub) 
			clave <= (clave==4'b0000)? 4'b1001 : clave-4'b0001;
		
	end
	
endmodule

//Detector de Transicion de Pulsos
 module PTD(clk, pulse,pulse_out);
    input clk,pulse;        
    output pulse_out;    
	 reg salida;
	 
	 initial salida='b0;
	 	 
	 always @(posedge clk) begin
			salida <= pulse;
	 end
	 
	 assign pulse_out = pulse && ~salida;

endmodule

// MODULO: Decodificador
module Decodificador( pulse, en0,en1,en2,en3);
	input pulse;	
	output reg en0,en1,en2,en3;
	reg [1:0] dec;
	initial dec = 2'b00;

	always @(posedge pulse) begin
		if(dec==2'b11)
			dec <= 2'b00;
		else
			dec <= dec + 2'b01;
	end
	always @(dec) begin
		case(dec)
			2'b00 : begin en0 <= 'b1; en1 <= 'b0; en2 <= 'b0; en3 <= 'b0; end
			2'b01 : begin en0 <= 'b0; en1 <= 'b1; en2 <= 'b0; en3 <= 'b0; end
			2'b10 : begin en0 <= 'b0; en1 <= 'b0; en2 <= 'b1; en3 <= 'b0; end
			2'b11 : begin en0 <= 'b0; en1 <= 'b0; en2 <= 'b0; en3 <= 'b1; end
		endcase
	end	
endmodule

module Divisor(clk,en_out);
	input clk;
	output en_out;
	reg en;
	integer cont;	
	
	initial begin en=0; cont= 0; end
	 
	always@(posedge clk) 
	begin
		cont = cont+1;
		if(cont==2) begin
			cont = 0;
			en = ~en;
		end
	end
	assign en_out = en;
endmodule

// MODULO: Displays
module Display(clk, clave, sevensegs,anodos);
	input clk;	
	input [15:0] clave;
	output reg [6:0] sevensegs;
	output reg [3:0] anodos;	
	reg [3:0] choose;
	
	initial begin sevensegs = 7'b1111111; anodos = 4'b1110; end
	
	always @(posedge clk) begin
		anodos <= (anodos==4'b1110)? 4'b1101 : (anodos==4'b1101)? 4'b1011 : (anodos==4'b1011)? 4'b0111 : (anodos==4'b0111)? 4'b1110: 4'b1110 ;
	end

	always @(posedge clk) begin
		case(anodos)
			4'b1110 : choose <= clave[3:0];
			4'b1101 : choose <= clave[7:4];
			4'b1011 : choose <= clave[11:8];
			4'b0111 : choose <= clave[15:12];
		endcase
	end
	
	always @(choose) begin
		case(choose)
			4'b0000 : sevensegs <= 7'b0000001;
			4'b0001 : sevensegs <= 7'b1001111;
			4'b0010 : sevensegs <= 7'b0010010;
			4'b0011 : sevensegs <= 7'b0000110;
			4'b0100 : sevensegs <= 7'b1001100;
			4'b0101 : sevensegs <= 7'b0100100;
			4'b0110 : sevensegs <= 7'b0100000;
			4'b0111 : sevensegs <= 7'b0001111;
			4'b1000 : sevensegs <= 7'b0000000;
			4'b1001 : sevensegs <= 7'b0001100;
			default : sevensegs <= 7'b0000001;
		endcase
	end
	
endmodule

//Undate And Check
module Update_And_Check(clave, pulse,switch,leds);
    input pulse,switch;   
	 input [15:0] clave;
    output reg [7:0] leds;    
	 reg [15:0] clave_save;
	 
	 initial leds=8'b0;	 	 	
	 
	 always@(posedge pulse) begin
		if(switch) begin clave_save <= clave; leds <= 8'b0; end
		else
		if(clave == clave_save)
			begin leds <= 8'b11111111; end
	 end

endmodule
