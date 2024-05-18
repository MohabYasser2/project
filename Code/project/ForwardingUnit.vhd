LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ForwardingUnit IS
    PORT (
        clk,SWAPPING1,SWAPPING2 : IN STD_LOGIC;
        Src1, Src2, ExDst, MemDst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        MemtoRegE, MemtoRegM : IN STD_LOGIC;
        ExResultMe, MemResult : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        ForwardedData1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Selector1, Selector2 : OUT STD_LOGIC
    );
END ForwardingUnit;

ARCHITECTURE Forwarding OF ForwardingUnit IS
signal S1,S2 : STD_LOGIC := '0';
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- Default selectors to '0

            -- Forwarding for Src1
            IF Src1 = MemDst AND MemtoRegM = '0' AND SWAPPING2 = '0' THEN
                ForwardedData1 <= MemResult;
                S1 <= '1';
            ELSIF Src1 = ExDst AND MemtoRegE = '1' AND SWAPPING1 = '0'THEN
                ForwardedData1 <= ExResultMe;
                S1 <= '1';
            ELSE
                -- Default case if no forwarding is needed
                S1 <= '0';
                ForwardedData1 <= (others => '0');
            END IF;

            -- Forwarding for Src2
            IF Src2 = MemDst AND MemtoRegM = '0'AND SWAPPING2 = '0' THEN
                ForwardedData1 <= MemResult;
                S2 <= '1';
            ELSIF Src2 = ExDst AND MemtoRegE = '1' AND SWAPPING1 = '0'THEN
                ForwardedData1 <= ExResultMe;
                S2 <= '1';
            ELSE
                -- Default case if no forwarding is needed
                S2 <= '0';
                ForwardedData1 <= (others => '0');
            END IF;
        END IF;
    END PROCESS;
    Selector1 <= S1;
    Selector2 <= S2;
END Forwarding;
