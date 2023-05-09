----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:58:56 05/03/2023 
-- Design Name: 
-- Module Name:    COLUMN - Behavioral 
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

ENTITY COLUMN IS

    GENERIC (
        n : POSITIVE := 8
    );
    PORT (
        CLK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        STATE : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        NEIGH_LEFT : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        NEIGH_RIGHT : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        DIRECTION : IN DIRECTION_T;
        EN : IN STD_LOGIC);
END COLUMN;

ARCHITECTURE Behavioral OF COLUMN IS
TYPE DIRECTION_T IS (DIR_LEFT, DIR_RIGHT, DIR_TOP);
BEGIN

    PROCESS (clk) IS
    BEGIN
        IF rising_edge(CLK) THEN
            IF EN = '1' THEN
                IF RESET = '1' THEN
                    STATE <= (OTHERS => '0');
                ELSE
                    IF DIRECTION = DIR_LEFT THEN
                        STATE <= NEIGH_RIGHT;
                    elsif DIRECTION = DIR_RIGHT THEN
                        STATE <= NEIGH_LEFT;
                    elsif DIRECTION = DIR_TOP THEN
                        for i in n-1 downto 1 loop
                            STATE(i) <= STATE(i-1);
                        end loop;
                        STATE(0) <= '0';
                    end if;
                END IF;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;