--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:26:42 05/05/2023
-- Design Name:   
-- Module Name:   G:/proj_template/FSM_tb.vhd
-- Project Name:  proj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FSM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments
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
use work.DIRTYPE.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY FSM_tb IS
END FSM_tb;

ARCHITECTURE behavior OF FSM_tb IS
constant ticks : positive := 16; -- number of ticks to perform whole shift
   -- Component Declaration for the Unit Under Test (UUT)

   COMPONENT FSM
      PORT (
         CLK : IN STD_LOGIC;
         RESET : IN STD_LOGIC;
         CNT1 : IN STD_LOGIC;
         CNT2 : IN STD_LOGIC;
         CNT3 : IN STD_LOGIC;
         IMG_CHNG : OUT STD_LOGIC;
			dir: OUT DIRECTION_T
      );
   END COMPONENT;

   --Inputs
   SIGNAL CLK : STD_LOGIC := '0';
   SIGNAL RESET : STD_LOGIC := '0';
   SIGNAL CNT1 : STD_LOGIC := '0';
   SIGNAL CNT2 : STD_LOGIC := '0';
   SIGNAL CNT3 : STD_LOGIC := '0';

   --Outputs
   SIGNAL IMG_CHNG : STD_LOGIC;
	signal dir: DIRECTION_T;
   -- Clock period definitions
   CONSTANT CLK_period : TIME := 10 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut : FSM PORT MAP(
      CLK => CLK,
      RESET => RESET,
      CNT1 => CNT1,
      CNT2 => CNT2,
      CNT3 => CNT3,
      IMG_CHNG => IMG_CHNG,
		dir => dir
   );

   counters : entity work.counter 
   GENERIC MAP(
			OUT1_PERIOD => ticks*3, --16*3 shifts left
			OUT2_PERIOD => ticks*3*2,--16*3 shifts right
			OUT3_PERIOD => ticks*3*2 + 8 --8 shifts up
		  )	 
		  PORT MAP (
        CLK => CLK,
        RESET => RESET,
        EN1 => CNT1,
        EN2 => CNT2,
        EN3 => CNT3
        );
   -- Clock process definitions
   CLK_process : PROCESS
   BEGIN
      CLK <= '0';
      WAIT FOR CLK_period/2;
      CLK <= '1';
      WAIT FOR CLK_period/2;
   END PROCESS;

   -- add sufficient encounters and try it out

   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      RESET <= '1';
      WAIT FOR 100 ns;
      RESET <= '0';
      WAIT FOR CLK_period * 10;

      -- insert stimulus here 

      WAIT;
   END PROCESS;

END;