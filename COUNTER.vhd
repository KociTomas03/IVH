-- Citac s volitelnou frekvenci
-- IVH projekt - ukol2
-- autor: xkocit00

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- v pripade nutnosti muzete nacist dalsi knihovny

ENTITY counter IS
	GENERIC (
		OUT1_PERIOD : POSITIVE := 1;
		OUT2_PERIOD : POSITIVE := 1;
		OUT3_PERIOD : POSITIVE := 1;
		OUT4_PERIOD: POSITIVE := 1
		);
	PORT (
		CLK : IN STD_LOGIC;
		RESET : IN STD_LOGIC;
		EN1 : OUT STD_LOGIC; -- image change
		EN2 : OUT STD_LOGIC; -- shifts of rotations left/right
		EN3 : OUT STD_LOGIC; -- number of rotations
		EN4 : OUT STD_LOGIC
	);
END counter;

ARCHITECTURE Behavioral OF counter IS
BEGIN

	C1: process (CLK, RESET)
	variable count: positive :=1;
	begin
		if reset =  '1' then
			count := 1;
			EN1 <= '0';
		elsif rising_edge(clk) then
			if count = OUT1_PERIOD then
				EN1 <= '1';
				count := 1;
			else
				EN1 <= '0';
				count := count + 1;
			end if;
		end if;
		
	end process;
	
	C2: process (CLK, RESET)
	variable count2: positive :=1;
	begin
		if reset =  '1' then
			count2 := 1;
			EN2 <= '0';
		elsif rising_edge(clk) then
			if count2 = OUT2_PERIOD then
				EN2 <= '1';
				count2 := 1;
			else
				EN2 <= '0';
				count2 := count2 + 1;
			end if;
		end if;
		
	end process;
	
	
	
	
	C3: process (CLK, RESET)
	variable count3: positive :=1;
	begin
		if reset =  '1' then
			count3 := 1;
			EN3 <= '0';
		elsif rising_edge(clk) then
			if count3 = OUT3_PERIOD then
				EN3 <= '1';
				count3 := 1;
			else
				EN3 <= '0';
				count3 := count3 + 1;
			end if;
		end if;
		
	end process;
	
	
	C4: process (CLK, RESET)
	variable count4: positive :=1;
	begin
		if reset =  '1' then
			count4 := 1;
			EN4 <= '0';
		elsif rising_edge(clk) then
			if count4 = OUT4_PERIOD then
				EN4 <= '1';
				count4 := 1;
			else
				EN4 <= '0';
				count4 := count4 + 1;
			end if;
		end if;
		
	end process;
	
	-- Napøíklad èítaè s periodou OUT1_PERIOD = 3 (t.j., každé 3 cykly)
	-- aktivuje na právì na jeden hodinový cyklus signál EN1. Analogicky 
	-- to bude fungovat i pro další dva kanály 

END Behavioral;