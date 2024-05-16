
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY MEMORY IS

PORT (
CLK,RST,PUSH,POP,MEM_WRITE:IN std_logic;
ALU_OUTPUT: IN std_logic_vector(31 DOWNTO 0);
Write_DATA: IN std_logic_vector(31 DOWNTO 0);
MEM_OUTPUT: OUT  std_logic_vector(31 DOWNTO 0);
FLAGS: IN std_logic_vector(3 downto 0);
BRANCH_SIG_IN : IN std_logic;
BRANCH_Z_SIG_IN : IN std_logic;
Protect_sig : IN std_logic;
free_sig : IN std_logic;



BRANCH_SIG : OUT std_logic;
BRANCH_Z_SIG : OUT std_logic

);

END ENTITY;

Architecture FetchUnit of MEMORY IS

component INC_DEC IS
	PORT(	CLK, RST,PUSH,POP: IN STD_LOGIC;
		DATAIN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATAOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END component;

component SP IS
	PORT(	CLK, RST: IN STD_LOGIC;
		DATAIN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATAOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END component;

Component DataMemory IS

PORT (
CLK,RST,WE : IN std_logic;
Protect_SIG,Free_SIG : IN std_logic;
ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
WriteData: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
DATAOUT : OUT std_logic_vector(31 DOWNTO 0)
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
Signal SP_TEMP : std_logic_vector(31 downto 0);
Signal INC_DEC_OUTPUT : std_logic_vector(31 downto 0);
signal OR_OUTPUT : std_logic;

BEGIN
OR_OUTPUT <= POP OR PUSH ;
BRANCH_SIG <= BRANCH_SIG_IN;
BRANCH_Z_SIG <= BRANCH_Z_SIG_IN AND FLAGS(0);

U0:Mux2x1 GENERIC MAP (32) PORT MAP(ALU_OUTPUT,SP_TEMP ,OR_OUTPUT,MUXOUT);

U1:DATAMEMORY PORT MAP(CLK,RST,MEM_WRITE,Protect_SIG,Free_Sig,MUXOUT,Write_data,MEM_OUTPUT);

U2:SP Port MAP(CLK,RST,INC_DEC_OUTPUT,SP_TEMP);

U3:INC_DEC Port MAP(CLK,RST,PUSH,POP,SP_TEMP,INC_DEC_OUTPUT);


END ARCHITECTURE;