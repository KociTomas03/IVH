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

ENTITY FSM IS
    PORT (
        CLK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        CNT1 : IN STD_LOGIC; -- counter and comparator to 16 - for shifts
        CNT2 : IN STD_LOGIC; -- counter and comparator to 3 - for shift repetitions
        CNT3 : IN STD_LOGIC; -- counter for shift up
        IMG_CHNG : OUT STD_LOGIC;
        dir: OUT DIRECTION_T
    );
END FSM;

ARCHITECTURE Behavioral OF FSM IS
    SIGNAL pstate : DIRECTION_T := DIR_LEFT;
    SIGNAL nstate : DIRECTION_T;
BEGIN

    nstateL : PROCESS (pstate, CNT1, CNT2, CNT3)IS
    BEGIN
        IMG_CHNG <= '0';
        CASE pstate IS
            WHEN DIR_LEFT =>
                IF CNT2 = '1' AND CNT1 = '1' THEN -- its 3rd cycle and last shift
                    nstate <= DIR_RIGHT;
                ELSIF CNT1 = '1' THEN
                    nstate <= DIR_LEFT;
                END IF;

            WHEN DIR_RIGHT =>
                IF CNT2 = '1' AND CNT1 = '1' THEN
                    nstate <= DIR_TOP;
                ELSIF CNT1 = '1' THEN
                    nstate <= DIR_RIGHT;
                END IF;

            WHEN DIR_TOP =>
                IF CNT3 = '1' THEN
                    nstate <= DIR_LEFT;
                    IMG_CHNG <= '1';
                else 
                    nstate <= DIR_TOP;
                END IF;
        END CASE;
    END PROCESS;
    pstateL : PROCESS (CLK, RESET)
    BEGIN
        IF RESET = '1' THEN
            dir <= DIR_LEFT;
            pstate <= DIR_LEFT;
        ELSIF rising_edge(CLK) THEN
            pstate <= nstate;
            dir <= nstate;
        END IF;
    END PROCESS;

END Behavioral;