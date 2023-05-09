-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.DIRTYPE.ALL;

ENTITY COLUMN_tb IS
END COLUMN_tb;

ARCHITECTURE behavior OF COLUMN_tb IS
        CONSTANT rows : POSITIVE := 8;
        -- Component Declaration
        COMPONENT COLUMN
                GENERIC (
                        n : POSITIVE
                );
                PORT (
                        CLK : IN STD_LOGIC;
                        RESET : IN STD_LOGIC;
                        STATE : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
                        INIT_STATE : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
                        NEIGH_LEFT : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
                        NEIGH_RIGHT : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
                        DIRECTION : IN DIRECTION_T;
                        EN : IN STD_LOGIC
                );
        END COMPONENT;
        SIGNAL CLK : STD_LOGIC := '0';
        SIGNAL RESET : STD_LOGIC := '0';
        SIGNAL STATE : STD_LOGIC_VECTOR(rows - 1 DOWNTO 0) := "00001111";
        SIGNAL INIT_STATE : STD_LOGIC_VECTOR(rows - 1 DOWNTO 0) := "11111111";
        SIGNAL NEIGH_LEFT : STD_LOGIC_VECTOR(rows - 1 DOWNTO 0) := "10000000";
        SIGNAL NEIGH_RIGHT : STD_LOGIC_VECTOR(rows - 1 DOWNTO 0) := "10101010";
        SIGNAL DIRECTION : DIRECTION_T := DIR_LEFT;
        SIGNAL EN : STD_LOGIC := '1';
        CONSTANT clk_period : TIME := 10 ns;
BEGIN

        -- Component Instantiation
        uut : COLUMN 
		  GENERIC MAP(
		  n => rows
		  )
		  PORT MAP(
                CLK => CLK,
                RESET => RESET,
                STATE => STATE,
                INIT_STATE => INIT_STATE,
                NEIGH_LEFT => NEIGH_LEFT,
                NEIGH_RIGHT => NEIGH_RIGHT,
                DIRECTION => DIRECTION,
                EN => EN
        );
        clk_process : PROCESS
        BEGIN
                clk <= '0';
                WAIT FOR clk_period/2;
                clk <= '1';
                WAIT FOR clk_period/2;
        END PROCESS;
        --  Test Bench Statements
        tb : PROCESS
        BEGIN
		RESET <= '1';
                WAIT FOR 100 ns; -- wait until global set/reset completes
                RESET <= '0';
                wait for clk_period*10 ;
                NEIGH_RIGHT <="00110011";
                wait for clk_period*10 ;
                RESET <= '1';
                wait for clk_period*10 ;
                RESET <= '0';
                wait for clk_period *10;
                DIRECTION <= DIR_RIGHT;
                NEIGH_LEFT <="11001100";
                wait for clk_period*10 ;
                DIRECTION <= DIR_TOP;
                wait for clk_period*10 ;
                -- Add user defined stimulus here

                WAIT; -- will wait forever
        END PROCESS tb;
        --  End Test Bench 

END;