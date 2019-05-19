library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;

entity Decodificador is
    Port ( pulso : in  STD_LOGIC;
           an0 : out  STD_LOGIC;
           an1 : out  STD_LOGIC;
           an2 : out  STD_LOGIC;
           an3 : out  STD_LOGIC);
end Decodificador;

architecture Behavioral of Decodificador is
	signal cont : STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
	
begin
	process(pulso) begin
		if(rising_edge(pulso)) then 
			cont <= cont + 1;
			if(cont = "100") then
				cont <= "000";
			end if;			
		end if;
	end process;
	
	decodificar: process(cont) 
	begin
			case cont is
				when "000" => an0 <= '1';
								 an1 <= '0';
								 an2 <= '0';
								 an3 <= '0';
				when "001" => an0 <= '0';
								 an1 <= '1';
								 an2 <= '0';
								 an3 <= '0';
				when "010" => an0 <= '0';
								 an1 <= '0';
								 an2 <= '1';
								 an3 <= '0';
				when "011" => an0 <= '0';
								 an1 <= '0';
								 an2 <= '0';
								 an3 <= '1';
				when others=>an0 <= '0';
								 an1 <= '0';
								 an2 <= '0';
								 an3 <= '0';
			end case;			 		 
	end process decodificar;


end Behavioral;

