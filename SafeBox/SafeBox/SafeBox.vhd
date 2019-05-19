library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SafeBox is
    Port ( clk : in  STD_LOGIC;
			  btn0,btn1,btn2,btn3: in  STD_LOGIC;
			  sw : in  STD_LOGIC;
			  an0,an1,an2,an3 : inout  STD_LOGIC;
			  display_out : out  STD_LOGIC_VECTOR (6 downto 0);
           leds : out  STD_LOGIC_VECTOR (7 downto 0)           
         );
end SafeBox;

architecture Behavioral of SafeBox is
	
	--Pulsos
	signal pulso0: STD_LOGIC := '0';
	signal pulso1: STD_LOGIC := '0';
	signal pulso2: STD_LOGIC := '0';
	signal pulso3: STD_LOGIC := '0';
	
	--Registros
	signal r0: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal r1: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal r2: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal r3: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');	
	
	--Registro Auxiliar para el display
	signal r_display: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');	
	
	component Detector_de_Pulso is
		port( clk : in  STD_LOGIC;
			  btn : in  STD_LOGIC;
           pulso : out  STD_LOGIC
			  );	
	end component;
	
	component Decodificador is
		port( pulso : in  STD_LOGIC;
           an0 : out  STD_LOGIC;
           an1 : out  STD_LOGIC;
           an2 : out  STD_LOGIC;
           an3 : out  STD_LOGIC
		);
	end component;
	
	component Operador is
		port( clk : in STD_LOGIC;
			   btn0 : in  STD_LOGIC;
				btn1 : in  STD_LOGIC;
            an : in  STD_LOGIC;
			   reg : inout STD_LOGIC_VECTOR (3 downto 0)
		);
	end component;
	
	component Display is
		port( reg_in : in  STD_LOGIC_VECTOR (3 downto 0);
				salida : out  STD_LOGIC_VECTOR (6 downto 0)
		);
	end component;
	
begin
	Detector0 : Detector_de_Pulso port map (clk,btn0,pulso0);
	Detector1 : Detector_de_Pulso port map (clk,btn1,pulso1);
	Detector2 : Detector_de_Pulso port map (clk,btn2,pulso2);
	Detector3 : Detector_de_Pulso port map (clk,btn3,pulso3);
	Dec : Decodificador port map (btn2,an0,an1,an2,an3);
	Operador1 : Operador port map (clk, btn0, btn1, an0, r0);
	Operador2 : Operador port map (clk, btn0, btn1, an1, r1);
	Operador3 : Operador port map (clk, btn0, btn1, an2, r2);
	Operador4 : Operador port map (clk, btn0, btn1, an3, r3);
	disp : Display port map (r_display, display_out);

	
	Selector : process(an0,an1,an2,an3) 
	begin		
		if(an0='0') then
			r_display <= r0;			
		else 
			if(an1='0') then
				r_display <= r0;						
			else
				if(an2='0') then
					r_display <= r0;
				else
					if(an3='0') then
						r_display <= r0;
					end if;
				end if;				
			end if;
		end if;

		
	end process Selector;
	
	
	
end Behavioral;

