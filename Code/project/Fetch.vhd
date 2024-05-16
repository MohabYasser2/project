LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Fetch IS

PORT (
CLK,RST:IN std_logic;
Branch0: IN std_logic;
BranchU: IN std_logic;
Stall: IN std_logic;
BranchAddress:IN std_logic_vector(31 DOWNTO 0);
PC_SAVED: OUT std_logic_vector(31 DOWNTO 0);
FetchedInstruction : OUT std_logic_vector(15 DOWNTO 0);
Swap_INST : IN std_logic_vector(15 DOWNTO 0);
EXTENDED_IMM: OUT std_logic_vector(31 DOWNTO 0)


);

END ENTITY;

Architecture FetchUnit of Fetch IS

Component PC IS
	PORT(	CLK, RST, STALL: IN STD_LOGIC;
		DATA_IN: IN STD_LOGIC_VECTOR(31 downto 0);
		RESET_VALUE: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATAOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END Component;

Component INSTRUCTION_CACHE IS

PORT (
CLK, RST : IN std_logic;
PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
DATAOUT : OUT std_logic_vector(15 DOWNTO 0);
RESET_VALUE: IN std_logic_vector(31 DOWNTO 0)
);

END Component;

component Mux2x1 IS
generic(N : INTEGER );
PORT(
I0,I1: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
S : IN STD_LOGIC;
O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0 ));

END component;

SIGNAL MUXOUT : STD_LOGIC_VECTOR(31 downto 0) :=(OTHERS => '0');
SIGNAL PC_OUT : STD_LOGIC_VECTOR(31 downto 0) := (OTHERS => '0');
SIGNAL B : STD_LOGIC;
SIGNAL AddOutput:  std_logic_vector(31 DOWNTO 0);
SIGNAL INST : std_logic_vector(15 DOWNTO 0);
SIGNAL RESET_VAL: std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
PROCESS(CLK, RST) IS
	
	BEGIN
		
		IF FAlling_edge(CLK) THEN
			
				AddOutput <= STD_LOGIC_VECTOR(UNSIGNED(PC_OUT) + 1);	
				END IF;
		
	END PROCESS;
	

PC_SAVED <= AddOutput;
B <= Branch0 OR BranchU;

EXTENDED_IMM <= "0000000000000000" & INST;
U0: PC PORT MAP(CLK,RST,STALL,MUXOUT,RESET_VAL,PC_OUT);
U1:Mux2x1 GENERIC MAP (32) PORT MAP(AddOutput,BranchAddress,B,MUXOUT);
U2:INSTRUCTION_CACHE PORT MAP(CLK,RST,PC_OUT,INST,RESET_VAL);
U3:Mux2x1 GENERIC MAP (16) PORT MAP(INST,Swap_INST,STALL,FetchedInstruction);


END ARCHITECTURE;
