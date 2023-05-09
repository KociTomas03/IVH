-- Testovani counteru, kod je tak, jak je vygenerovan od ISE
-- Autor: xkocit00

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counter_tb IS
END counter_tb;

ARCHITECTURE behavior OF counter_tb IS
    --Inputs
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL RESET : STD_LOGIC := '0';

    --Outputs
    SIGNAL EN1 : STD_LOGIC;
    SIGNAL EN2 : STD_LOGIC;
    SIGNAL EN3 : STD_LOGIC;
	 SIGNAL EN4 : STD_LOGIC;


    -- Clock period definitions
    CONSTANT CLK_period : TIME := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    -- muzete samozrejme nastavit i genericke parametry!
    -- pozor na dobu simulace (nenastavujte moc dlouhe casy nebo zkratte CLK_period)
    -- Pocitejte s tim, ze pri zkouseni pobezi testbench 100 ms
    uut : ENTITY work.counter
			GENERIC MAP(
			OUT1_PERIOD => 2,
			OUT2_PERIOD => 3,
			OUT3_PERIOD => 5,
			OUT4_PERIOD => 7
		  )	 
		  PORT MAP (
        CLK => CLK,
        RESET => RESET,
        EN1 => EN1,
        EN2 => EN2,
        EN3 => EN3,
		  EN4 => EN4
        );

    -- Clock process definitions
    CLK_process : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR CLK_period/2;
        CLK <= '1';
        WAIT FOR CLK_period/2;
    END PROCESS;
    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- hold reset state for 100 ns.
        RESET <= '1';
        WAIT FOR 100 ns;
        RESET <= '0';
			
			WAIT FOR CLK_period/2;
			WAIT FOR CLK_period * 9;

			assert EN1 = '0' report "Problem EN1 at 9th clock cycle";
			assert EN2 = '1' report "Problem EN2 at 9th clock cycle";
			assert EN3 = '0' report "Problem EN3 at 9th clock cycle";
			
			WAIT FOR CLK_period * 21;
			assert EN1 = '1' report "Problem EN1 at 30th clock cycle";
			assert EN2 = '1' report "Problem EN2 at 30th clock cycle";
			assert EN3 = '1' report "Problem EN3 at 30th clock cycle";
			
			
			WAIT FOR CLK_period * 2;
			assert EN1 = '1' report "Problem EN1 at 32nd clock cycle";
			assert EN2 = '0' report "Problem EN2 at 32nd clock cycle";
			assert EN3 = '0' report "Problem EN3 at 32nd clock cycle";
			
			WAIT FOR CLK_period * 3;
			assert EN1 = '0' report "Problem EN1 at 35th clock cycle";
			assert EN2 = '0' report "Problem EN2 at 35th clock cycle";
			assert EN3 = '1' report "Problem EN3 at 35th clock cycle";

        WAIT;
    END PROCESS;

END;