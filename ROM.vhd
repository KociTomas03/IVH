----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:43 05/03/2023 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY ROM IS
	GENERIC (
		SIZE : POSITIVE := 128
	);
	PORT (
		clk : IN STD_LOGIC;
		en : IN STD_LOGIC;
		im : IN INTEGER RANGE 0 TO 3;
		offset : IN INTEGER RANGE 0 TO 127;
		data : OUT STD_LOGIC_VECTOR (SIZE - 1 DOWNTO 0)
	);
END ROM;

ARCHITECTURE Behavioral OF ROM IS
	-- 00000000010000100111111001111110010000100000000001100000000110000000011000000110000110000110000000000000011111100001100001111110
	-- 00000000000000000111111001010000010100000100000000000000010000100111111001000010000000000100000001000000011111100100000001000000
	-- 00000000000000000000000000110000011110001111110011111110011111111111111011111100011110000011000000000000000000000000000000000000
	-- 00000000000000000000000000111100010000101000100110100101100001011000010110100101100010010100001000111100000000000000000000000000
	CONSTANT rom : STD_LOGIC_VECTOR(511 DOWNTO 0) := "00000000010000100111111001111110010000100000000001100000000110000000011000000110000110000110000000000000011111100001100001111110000000000000000001111110010100000101000001000000000000000100001001111110010000100000000001000000010000000111111001000000010000000000000000000000000000000011000001111000111111001111111001111111111111101111110001111000001100000000000000000000000000000000000000000000000000000000000000111100010000101000100110100101100001011000010110100101100010010100001000111100000000000000000000000000";
BEGIN
	PROCESS (clk, en)IS
		VARIABLE begining : POSITIVE := im * 128 + offset + size;
	BEGIN
		IF rising_edge(clk) THEN
			begining:= im * 128 + offset + size;
			IF en = '1' THEN
				data <= rom(begining - 1 DOWNTO begining - size);
			END IF;
		END IF;
	END PROCESS;
END;