library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 

entity Operador is
    Port ( clk : in STD_LOGIC;
			  btn0,btn1 : in  STD_LOGIC;
           an : in  STD_LOGIC;
			  reg : inout STD_LOGIC_VECTOR (3 downto 0)
			  );           
end Operador;

architecture Behavioral of Operador is
	
	
begin
	process(clk) begin
		if rising_edge (clk) then
			if(an = '0') then
				if(btn0 = '1')then
					reg <= reg + 1;
					if(reg = "1010")then
						reg <= "0000";
					end if;
				end if;
				if(btn1 = '1')then
					reg <= reg - 1;
					if(reg = "1110")then
						reg <= "1001";
					end if;
				end if;
			end if;		
		end if;
	end process;
	
end Behavioral;

