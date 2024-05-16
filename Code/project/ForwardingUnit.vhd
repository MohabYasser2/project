LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ForwardingUnit IS
    PORT (
        clk : IN STD_LOGIC;
        Src1, Src2, ExDst, MemDst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        ExResultMe, MemResult : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        MemtoReg : IN STD_LOGIC;
        ForwardedData : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Selector1, Selector2 : OUT STD_LOGIC
    );
END ForwardingUnit;

ARCHITECTURE Forwarding OF ForwardingUnit IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF MemtoReg = '0' THEN
                -- Compare SRC1 to MemDst
                IF Src1 = MemDst THEN
                    ForwardedData <= MemResult;
                    Selector1 <= '1';
                ELSE
                    Selector1 <= '0';
                END IF;

                -- Compare SRC2 to MemDst
                IF Src2 = MemDst THEN
                    ForwardedData <= MemResult;
                    Selector2 <= '1';
                ELSE
                    Selector2 <= '0';
                END IF;
            ELSIF MemtoReg = '1' THEN
                -- Compare SRC1 to ExDst
                IF Src1 = ExDst THEN
                    ForwardedData <= ExResultMe;
                    Selector1 <= '1';
                ELSE
                    Selector1 <= '0';
                END IF;

                -- Compare SRC2 to ExDst
                IF Src2 = ExDst THEN
                    ForwardedData <= ExResultMe;
                    Selector2 <= '1';
                ELSE
                    Selector2 <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
END Forwarding;

