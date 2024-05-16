
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY INC_DEC IS
	PORT(	CLK, RST,PUSH,POP: IN STD_LOGIC;
		DATAIN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATAOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE SP_ARCH OF INC_DEC IS
	

	SIGNAL TEMP_DATAIN: STD_LOGIC_VECTOR(31 DOWNTO 0) ;
BEGIN
	PROCESS(CLK, RST) IS
	
	BEGIN
		IF RST = '1' THEN
			Temp_DATAIN <= "00000000000000000000111111111111";
		ELSIF RISING_EDGE(CLK) 
		THEN
			Temp_DATAIN <= DATAIN;
			IF PUSH = '1' THEN			
			Temp_DATAIN <= STD_LOGIC_VECTOR(UNSIGNED(DATAIN) - 2);
			END IF;
			IF POP = '1' THEN
			Temp_DATAIN <= STD_LOGIC_VECTOR(UNSIGNED(DATAIN) + 2);
			END IF;
		END IF;
	END PROCESS;
	
	DATAOUT <= Temp_DATAIN;

END ARCHITECTURE;
