--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:23:30 06/26/2012
-- Design Name:   
-- Module Name:   E:/Universidad/Semestre 6/Electronica II/Safe Box/SafeBox_v/tb_PTD.vhd
-- Project Name:  SafeBox_v
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PTD
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_PTD IS
END tb_PTD;
 
ARCHITECTURE behavior OF tb_PTD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PTD
    PORT(
         clk : IN  std_logic;
         pulse : IN  std_logic;
         pulse_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pulse : std_logic := '0';

 	--Outputs
   signal pulse_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PTD PORT MAP (
          clk => clk,
          pulse => pulse,
          pulse_out => pulse_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		pulse <= '1';
		wait for 100 ns;	
		pulse <= '0';
		wait for 100 ns;	
		pulse <= '1';
		wait for 100 ns;	
		pulse <= '0';
      -- insert stimulus here 

      wait;   
   end process;

END;
