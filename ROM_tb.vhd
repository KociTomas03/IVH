--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:01:01 05/03/2023
-- Design Name:   
-- Module Name:   G:/proj_template/ROM_tb.vhd
-- Project Name:  proj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ROM
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

ENTITY ROM_tb IS
END ROM_tb;

ARCHITECTURE behavior OF ROM_tb IS
   CONSTANT size : POSITIVE := 128;
   -- Component Declaration for the Unit Under Test (UUT)

   COMPONENT ROM
      GENERIC (
         SIZE : POSITIVE
      );
      PORT (
         clk : IN STD_LOGIC;
         en : IN STD_LOGIC;
         offset : IN INTEGER RANGE 0 TO 127 := 0;
         im : INOUT INTEGER RANGE 0 TO 3;
         data : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
      );
   END COMPONENT;
   --Inputs
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL en : STD_LOGIC := '0';
   SIGNAL im :INTEGER RANGE 0 TO 3 := 0;
   signal offset: INTEGER RANGE 0 TO 127 := 0;
   --Outputs
   SIGNAL data : STD_LOGIC_VECTOR(size - 1 DOWNTO 0);

   -- Clock period definitions
   CONSTANT clk_period : TIME := 10 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut : ROM
   GENERIC MAP(
      SIZE => size
   )
   PORT MAP(
      clk => clk,
      en => en,
      offset => offset,
      im => im,
      data => data
   );

   -- Clock process definitions
   clk_process : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period/2;
      clk <= '1';
      WAIT FOR clk_period/2;
   END PROCESS;
   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      WAIT FOR 100 ns;

      en <= '1';
      WAIT FOR clk_period * 20;
      im <= 0;
      WAIT FOR clk_period * 20;
      im <= 2;
      WAIT FOR clk_period * 20;
      im <= 0;
      WAIT FOR clk_period * 20;
      im <= 3;
      WAIT FOR clk_period * 20;
      -- insert stimulus here 

      WAIT;
   END PROCESS;

END;