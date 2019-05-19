library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;

entity Display is
    Port ( reg_in : in  STD_LOGIC_VECTOR (3 downto 0);
           salida : out  STD_LOGIC_VECTOR (6 downto 0));
end Display;

architecture Behavioral of Display is

begin
	process(reg_in)begin
		case (reg_in) is
			when "0000" => salida <= "0000001";
			when "0001" => salida <= "1001111";
			when "0010" => salida <= "0010010";
			when "0011" => salida <= "0000110";
			when "0100" => salida <= "1001100";
			when "0101" => salida <= "0100100";
			when "0110" => salida <= "0100000";
			when "0111" => salida <= "0001111";
			when "1000" => salida <= "0000000";
			when "1001" => salida <= "0001100";
			when others => salida <= "1111111";
		end case;
	end process;

end Behavioral;

