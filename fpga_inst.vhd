LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.DIRTYPE.ALL;

ARCHITECTURE Behavioral OF tlv_gp_ifc IS
    SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
    SIGNAL R : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01011100";
    SIGNAL cnt : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); -- 1s - 25MHz / 20M ~ 24b

    --counters
    SIGNAL CNT1 : STD_LOGIC := '0';
    SIGNAL CNT2 : STD_LOGIC := '0';
    SIGNAL CNT3 : STD_LOGIC := '0';
	 SIGNAL CNT4 : STD_LOGIC := '0';


    -- img
    SIGNAL IMG_CHNG : STD_LOGIC := '1';
    SIGNAL IMG : STD_LOGIC_VECTOR(127 DOWNTO 0) := "00000000010000100111111001111110010000100000000001100000000110000000011000000110000110000110000000000000011111100001100001111110";
    -- defaultly 1st image
    SIGNAL IMG_CNT : INTEGER RANGE 0 TO 3 := 0;

    -- cols
    TYPE cols_arr IS ARRAY(15 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL cols : cols_arr;
    --fsm
    SIGNAL dir : DIRECTION_T;
	
    CONSTANT ticks : INTEGER := 16;
	 
		
	
BEGIN

    PROCESS (clk) IS
    BEGIN
        IF rising_edge(clk) THEN
            cnt <= cnt + 1;
            IF conv_integer(cnt) = 0 THEN
                A <= A + 1;
            END IF;
        END IF;

    END PROCESS;

    PROCESS (clk) IS -- selects col to be shown
    BEGIN
        IF rising_edge(clk) THEN
            R <= cols(conv_integer(A));
        END IF;
    END PROCESS;


    process (clk, IMG_CHNG) is 
    begin
        if rising_edge(clk)then
            if IMG_CHNG = '1' then
                IMG_CNT <= (IMG_CNT +1) mod 4;
                end if;
            end if;
        end process;

    rom : ENTITY work.ROM GENERIC MAP(
        SIZE => 128
        )
        PORT MAP(
            clk => clk,
            en => IMG_CHNG,
            offset => 0,
            im => IMG_CNT,
            data => IMG
        );

    counters : ENTITY work.counter
        GENERIC MAP(
            OUT1_PERIOD => ticks *16* 3, --16*3 shifts left
            OUT2_PERIOD => ticks *16* 3 * 2, --16*3 shifts right
            OUT3_PERIOD => ticks *16* 3 * 2 + 8, --8 shifts up
			OUT4_PERIOD => ticks
        )
        PORT MAP(
            CLK => clk,
            RESET => reset,
            EN1 => CNT1,
            EN2 => CNT2,
            EN3 => CNT3,
				EN4 => CNT4
        );

    fsm : ENTITY work.FSM PORT MAP(
        CLK => clk,
        RESET => reset,
        CNT1 => CNT1,
        CNT2 => CNT2,
        CNT3 => CNT3,
        IMG_CHNG => IMG_CHNG,
        dir => dir
        );


    COL0 : ENTITY work.COLUMN
        GENERIC MAP(
            n => 8
        )
        PORT MAP(
            CLK => clk,
            RESET => reset,
            STATE => cols(0),
            INIT_STATE => IMG (7 downto 0),
            NEIGH_LEFT => cols(15),
            NEIGH_RIGHT => cols(1),
            DIRECTION => dir,
            EN => CNT4
        );

    COLGEN : FOR i IN 1 TO 14 GENERATE
    BEGIN
        col : ENTITY work.COLUMN
            GENERIC MAP(
                n => 8
            )
            PORT MAP(
                CLK => clk,
                RESET => RESET,
                STATE => cols(i),
                INIT_STATE => IMG(i*8+7 downto i*8),
                NEIGH_LEFT => cols(i - 1),
                NEIGH_RIGHT => cols(i + 1),
                DIRECTION => dir,
                EN => CNT4
            );
    END GENERATE COLGEN;
    COL15 : ENTITY work.COLUMN
        GENERIC MAP(
            n => 8
        )
        PORT MAP(
            CLK => clk,
            RESET => RESET,
            STATE => cols(15),
            INIT_STATE => IMG(127 downto 120),
            NEIGH_LEFT => cols(14),
            NEIGH_RIGHT => cols(0),
            DIRECTION => dir,
            EN => CNT4
        );

    -- mapovani vystupu
    -- nemenit
    X(6) <= A(3);
    X(8) <= A(1);
    X(10) <= A(0);
    X(7) <= '0'; -- en_n
    X(9) <= A(2);

    X(16) <= R(1);
    X(18) <= R(0);
    X(20) <= R(7);
    X(22) <= R(2);

    X(17) <= R(4);
    X(19) <= R(3);
    X(21) <= R(6);
    X(23) <= R(5);
END Behavioral;