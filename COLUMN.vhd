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
USE work.DIRTYPE.ALL;
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
        INIT_STATE : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        NEIGH_LEFT : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        NEIGH_RIGHT : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        DIRECTION : IN DIRECTION_T;
        EN : IN STD_LOGIC
    );
END COLUMN;

ARCHITECTURE Behavioral OF COLUMN IS
    SIGNAL sstate : STD_LOGIC_VECTOR(n - 1 DOWNTO 0) := INIT_STATE;
BEGIN

    PROCESS (CLK) IS
    BEGIN
        IF rising_edge(CLK) THEN
            IF RESET = '1' THEN
                sstate <= INIT_STATE;
            END IF;
            IF EN = '1' THEN
                IF DIRECTION = DIR_LEFT THEN
                    sstate <= NEIGH_LEFT;
                ELSIF DIRECTION = DIR_RIGHT THEN
                    sstate <= NEIGH_RIGHT;
                ELSIF DIRECTION = DIR_TOP THEN
                    sstate <= '0' & sstate(n - 1 DOWNTO 1);
                END IF;
            END IF;
        STATE <= sstate;
        END IF;
    END PROCESS;
END;