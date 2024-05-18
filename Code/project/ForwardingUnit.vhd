LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ForwardingUnit IS
PORT (
    clk,SWAPPING1,SWAPPING2,REGWRITE1,REGWRITE2 : IN STD_LOGIC;
    Src1, Src2, ExDst, MemDst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    MemtoRegE, MemtoRegM : IN STD_LOGIC;
    ExResultMe, MemResult : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    ForwardedData1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Selector1, Selector2 : OUT STD_LOGIC
    );
    END ForwardingUnit;
    
    ARCHITECTURE Forwarding OF ForwardingUnit IS
    
    signal SAVED_DATA1 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    signal SAVED_DATA2 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
begin
    PROCESS (clk)
    VARIABLE S1,S2 : STD_LOGIC := '0';
    variable ForwardedData : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    BEGIN
    if falling_edge(clk) then
        SAVED_DATA1 <= exResultMe;
        SAVED_DATA2 <= memResult;
    end if;    
    IF RISING_EDGE(clk) THEN
            -- Default selectors to '0
            S1 := '0';
            S2 := '0';
            ForwardedData := (others => '0');
            -- Forwarding for Src1
            IF Src1 = MemDst AND MemtoRegM = '0' AND SWAPPING2 = '0' AND REGWRITE1 ='1'THEN
                ForwardedData := Saved_Data2;
                S1 := '1';
            END if;
            IF Src1 = ExDst AND MemtoRegE = '1' AND SWAPPING1 = '0' AND REGWRITE2 ='1'THEN
                ForwardedData := Saved_Data1;
                S1 := '1';
            END IF; 
            if Src2 = MemDst AND MemtoRegM = '0'AND SWAPPING2 = '0'AND REGWRITE1 ='1' THEN
                ForwardedData := Saved_Data2;
                S2 := '1';
                END if;
            IF Src2 = ExDst AND MemtoRegE = '1' AND SWAPPING1 = '0'AND REGWRITE2 ='1'THEN
                ForwardedData := Saved_Data1;
                S2 := '1';
         
            END IF;
            
            Selector1 <= S1;
            Selector2 <= S2;
            ForwardedData1 <= ForwardedData;

        END IF;
    END PROCESS;
    
END Forwarding;
