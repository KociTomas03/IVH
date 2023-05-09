--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package DIRTYPE is
function GETCOLUMN (signal DATA : in std_logic_vector; COLID : in integer; ROWS: in integer) return std_logic_vector;
TYPE DIRECTION_T IS (DIR_LEFT, DIR_RIGHT, DIR_TOP);
end DIRTYPE;

package body DIRTYPE is
    function GETCOLUMN (signal DATA : in std_logic_vector; COLID : in integer; ROWS: in integer) return std_logic_vector is
        variable RES : std_logic_vector( ROWS-1 downto 0);
        begin
            if COLID < 0 then
                RES := DATA(DATA'LENGTH-1 downto DATA'LENGTH-ROWS-1 );
                return RES;
            end if;
            if COLID>DATA'length / ROWS then
                RES := DATA( ROWS-1 downto 0);
                else
                    RES := DATA(ROWS*COLID+ROWS-1 downto ROWS*COLID);
            end if;
        return RES;
        end GETCOLUMN;
end DIRTYPE;
