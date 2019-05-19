library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Detector_de_Pulso is
    Port ( clk : in  STD_LOGIC;
			  btn : in  STD_LOGIC;
           pulso : out  STD_LOGIC
			 );
end Detector_de_Pulso;

architecture Behavioral of Detector_de_Pulso is
	
	signal salida: STD_LOGIC := '0';
	
	component FF_D is
		port( clk : in  STD_LOGIC;
            entrada : in  STD_LOGIC;
            salida : out  STD_LOGIC
			  );	
	end component;
	
begin
	Flip_FLop_D : FF_D port map (clk,btn,salida);
	pulso <= btn and  not salida;	
end Behavioral;

