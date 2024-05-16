LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY EXECUTE IS

PORT (
CLK,RST:IN std_logic;
ALU_SRC: IN std_logic;
OP_CODE:IN std_logic_vector(4 DOWNTO 0);
Read_Data1: IN std_logic_vector(31 DOWNTO 0);
Read_Data2: IN std_logic_vector(31 DOWNTO 0);
IMM_VALUE: IN std_logic_vector(31 DOWNTO 0);
ALU_OUTPUT: OUT  std_logic_vector(31 DOWNTO 0);
FLAGS: OUT std_logic_vector(3 downto 0)
);

END ENTITY;

Architecture FetchUnit of EXECUTE IS

component ALU IS
PORT(
	CLK,RST: IN STD_LOGIC ;
	A,B: IN STD_LOGIC_VECTOR (31 downto 0);
	OP_CODE : IN std_logic_vector (4 DOWNTO 0);
	F: OUT std_logic_vector (31 downto 0);
	FLAGS_IN: OUT STD_LOGIC_VECTOR (3 downto 0)
);
END component;

component CCR IS
	PORT(
		CLK, RST : IN STD_LOGIC;
		DATAIN: IN STD_LOGIC_VECTOR(3 downto 0);
		DATAOUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END component;


component Mux2x1 IS
generic(N : INTEGER );
PORT(
I0,I1: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
S : IN STD_LOGIC;
O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0 ));

END component;

--Signals
Signal MUXOUT : std_logic_vector(31 DOWNTO 0);
signal temp_flags : std_logic_vector(3 downto 0);
BEGIN

U0:Mux2x1 GENERIC MAP (32) PORT MAP(read_data2,imm_value ,ALU_SRC,MUXOUT);
U1:ALU PORT MAP(CLK,RST,Read_data1,MUXOUT,OP_CODE,AlU_OUTPUT,temp_flags);
U2:CCR Port MAP(CLK,RST,temp_flags,FLAGS);


END ARCHITECTURE;
