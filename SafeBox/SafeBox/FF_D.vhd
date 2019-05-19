library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D is
    Port ( clk : in  STD_LOGIC;
           entrada : in  STD_LOGIC;
           salida : out  STD_LOGIC
			  );
end FF_D;

architecture Behavioral of FF_D is

begin
	process(clk) begin 
		if(rising_edge(clk))then
			salida <= entrada;
		end if;
	end process;
	

end Behavioral;

