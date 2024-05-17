
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY MAIN_PROCESSOR IS

PORT (
CLK,RST:IN std_logic;
IN_PORT: IN std_logic_vector(31 DOWNTO 0);
OUT_PORT: OUT std_logic_vector(31 DOWNTO 0)


);

END ENTITY;


Architecture MAIN of MAIN_PROCESSOR IS

COMPONENT Fetch IS

PORT (
CLK,RST,INTERRUPT_SIG,RESET_SIG:IN std_logic;
Branch0: IN std_logic;
BranchU: IN std_logic;
Stall: IN std_logic;
BranchAddress:IN std_logic_vector(31 DOWNTO 0);
PC_SAVED: OUT std_logic_vector(31 DOWNTO 0);
FetchedInstruction : OUT std_logic_vector(15 DOWNTO 0);
Swap_INST : IN std_logic_vector(15 DOWNTO 0);
EXTENDED_IMM: OUT std_logic_vector(31 DOWNTO 0)


);

END COMPONENT;


COMPONENT F_D IS


PORT(	CLK, RST,PREV_STALL_IN: IN STD_LOGIC;
INST: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
PC: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
IN_PORT_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
INTERRUPT_SIG: IN STD_LOGIC;
PREV_STALL_OUT: OUT STD_LOGIC;
PC_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
OP_CODE: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
SRC1, SRC2, DEST: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
IN_PORT_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
INTERRUPT_SIG_OUT: OUT STD_LOGIC





);	
END COMPONENT;

COMPONENT DecodeUnit IS

PORT (
CLK,RST:IN std_logic;
opcode: IN std_logic_vector(4 DOWNTO 0);
ReadReg1: IN std_logic_vector(2 DOWNTO 0);
ReadReg2: IN std_logic_vector(2 DOWNTO 0);
RegWRPipeline: IN std_logic;
WriteReg:Std_logic_vector(31 DOWNTO 0);
WriteAdd:std_logic_vector(2 DOWNTO 0);
ReadData1: OUT std_logic_vector(31 DOWNTO 0);
ReadData2: OUT std_logic_vector(31 DOWNTO 0);

MemtoReg, ALUSrc,RegWrite : OUT std_logic;
MemWrite: OUT std_logic;
Stall,Swap,Branch0,BranchU: OUT std_logic;
Push,Pop,Insig: OUT std_logic;
Protect,Free: OUT std_logic;
callSig,retSig: OUT STD_LOGIC;
Swaped_INST :OUT std_logic_vector(15 downto 0);
OUT_PORT:OUT std_logic_vector(31 DOWNTO 0)


);
END COMPONENT;

COMPONENT D_E IS
PORT(	CLK, RST: IN STD_LOGIC;
		MemToReg,RegWrite,MemWrite,Branch_Sig,Branch_Z_Sig,PUSH,POP,In_SIG,Protect,Free,ALU_SRC: IN STD_LOGIC;
		PC,READ_DATA1,READ_DATA2,IMM_VALUE: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
		IN_PORT_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);  
		WRITE_ADDRESS:IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		OP_CODE: IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
		callSig: IN STD_LOGIC;
		RET_SIG: IN STD_LOGIC;
		RTI_SIG: IN STD_LOGIC;
		INTERRUPT_SIG: IN STD_LOGIC;

		MemToReg_OUT,RegWrite_OUT,MemWrite_OUT,Branch_Sig_OUT,Branch_Z_Sig_OUT,PUSH_OUT,POP_OUT,In_SIG_OUT,Protect_OUT,Free_OUT,ALU_SRC_OUT: OUT STD_LOGIC;
		PC_OUT,READ_DATA1_OUT,READ_DATA2_OUT,IMM_VALUE_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
		IN_PORT_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);  
		WRITE_ADDRESS_OUT:OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		OP_CODE_D_E: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		callSig_out: OUT STD_LOGIC;
		RET_SIG_OUT: OUT STD_LOGIC;
		RTI_SIG_OUT: OUT STD_LOGIC;
		INTERRUPT_SIG_OUT: OUT STD_LOGIC





);
		
END COMPONENT;

COMPONENT EXECUTE IS

PORT (
CLK,RST:IN std_logic;
ALU_SRC: IN std_logic;
OP_CODE:IN std_logic_vector(4 DOWNTO 0);
Read_Data1: IN std_logic_vector(31 DOWNTO 0);
Read_Data2: IN std_logic_vector(31 DOWNTO 0);
IMM_VALUE: IN std_logic_vector(31 DOWNTO 0);
RTI_SIG: IN std_logic;
RTI_FLAGS: IN std_logic_vector(3 DOWNTO 0);
ALU_OUTPUT: OUT  std_logic_vector(31 DOWNTO 0);
FLAGS: OUT std_logic_vector(3 downto 0)
);

END COMPONENT;

COMPONENT E_M IS
PORT(	CLK, RST: IN STD_LOGIC;
Alu_output: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
PC: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
CCR_Flags: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
WriteAddress :IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
inport :IN std_logic_vector(31 DOWNTO 0);
MemToReg :IN std_logic;
RegWrite : IN std_logic;
MemWrite : IN std_logic;
Branch_Sig  :IN std_logic;
Branch_Z_Sig  :IN std_logic;
PUSH  :IN std_logic;
POP  :IN std_logic;
In_SIG  :IN std_logic;
Protect  :IN std_logic;
Free  :IN std_logic;
Write_data:IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
callSig: IN STD_LOGIC;
RET_SIG: IN STD_LOGIC;
RTI_SIG: IN STD_LOGIC;
INTERRUPT_SIG: IN STD_LOGIC;


Alu_outputOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
PCOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
CCR_FlagsOut: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
WriteAddressOut  :OUT STD_LOGIC_VECTOR(2 DOWNTO 0); 
inportOut  :OUT std_logic_vector(31 DOWNTO 0);
MemToRegOut  :OUT std_logic;
RegWriteOut  :OUT std_logic;
MemWriteOut  :OUT std_logic;
Branch_SigOut :OUT std_logic;
Branch_Z_SigOut  :OUT std_logic;
PUSHOut  :OUT std_logic;
POPOut  : OUT std_logic;
In_SIGOut: OUT std_logic;
ProtectOut : OUT std_logic;
FreeOut :OUT std_logic;
Write_data_out:out STD_LOGIC_VECTOR(31 DOWNTO 0);
callSig_out: OUT STD_LOGIC;
RET_SIG_out: OUT STD_LOGIC;
RTI_SIG_out: OUT STD_LOGIC;
INTERRUPT_SIG_out: OUT STD_LOGIC




);
		
END COMPONENT;

COMPONENT MEMORY IS

PORT (
CLK,RST,PUSH,POP,MEM_WRITE,INTERRUPT_SIG:IN std_logic;
ALU_OUTPUT: IN std_logic_vector(31 DOWNTO 0);
Write_DATA: IN std_logic_vector(31 DOWNTO 0);
MEM_OUTPUT: OUT  std_logic_vector(31 DOWNTO 0);
FLAGS: IN std_logic_vector(3 downto 0);
BRANCH_SIG_IN : IN std_logic;
BRANCH_Z_SIG_IN : IN std_logic;
Protect_sig : IN std_logic;
Free_sig: IN STD_LOGIC;
PC: IN std_logic_vector(31 DOWNTO 0);
callSig: IN STD_LOGIC;
RET_SIG: IN STD_LOGIC;
RTI_SIG: IN STD_LOGIC;

RET_SIG_OUT: OUT STD_LOGIC;
RTI_SIG_OUT: OUT STD_LOGIC;
BRANCH_SIG : OUT std_logic;
BRANCH_Z_SIG : OUT std_logic;
FLUSH_SIG: OUT STD_LOGIC;
Flags_out: OUT std_logic_vector(3 DOWNTO 0)
);

END COMPONENT;

COMPONENT M_WB IS
PORT(	CLK, RST: IN STD_LOGIC;
MemToReg,RegWrite,In_SIG: IN STD_LOGIC;
MEM_OUTPUT,ALU_OUTPUT,IN_PORT: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
Write_Address: IN STD_LOGIC_VECTOR(2 DOWNTO 0); 

MemToReg_OUT,RegWrite_OUT,In_SIG_OUT: OUT STD_LOGIC;
MEM_OUTPUT_OUT,ALU_OUTPUT_OUT,IN_PORT_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
Write_Address_OUT: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)





);
		
END COMPONENT;

component Mux2x1 IS
generic(N : INTEGER );
PORT(
I0,I1: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
S : IN STD_LOGIC;
O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0 ));

END component;

SIGNAL BRANCH_SIG, BRANCH_Z_SIG,STALL,PREV_STALL_OUT: STD_LOGIC;
SIGNAL ALU_OUTPUT,ALU_OUTPUT_E_M,IN_PORT_F_D,IN_PORT_D_E,IN_PORT_E_M,IN_PORT_M_WB: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ReadData1,ReadData2,ReadData1_D_E,ReadData2_D_E,ReadData1_E_M,ReadData2_E_M: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL WRITE_ADDRESS_F_D,WRITE_ADDRESS_D_E,WRITE_ADDRESS_E_M,WRITE_ADDRESS_M_WB: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL OP_CODE_F_D,OP_CODE_D_E: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL MemToReg,MemtoReg_D_E,MemToReg_E_M,MemToReg_M_WB,RegWrite,RegWrite_D_E,RegWrite_E_M,RegWrite_M_WB,MemWrite,MemWrite_D_E,MemWrite_E_M,MemWrite_M_WB: STD_LOGIC;
SIGNAL PC_SAVED_1,PC_OUT_F_D,PC_OUT_D_E,PC_OUT_E_M,PC_OUT_M_WB: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL FetchedInstruction,Swaped_INST : std_logic_vector(15 DOWNTO 0);

SIGNAL EXTENDED_IMM : std_logic_vector(31 DOWNTO 0);
SIGNAL SRC1, SRC2 : std_logic_vector(2 DOWNTO 0);

SIGNAL PUSH, POP, In_SIG, Protect, Free, ALU_SRC,swap : std_logic;
SIGNAL Branch_Sig_D_E, Branch_Z_Sig_D_E : std_logic;
SIGNAL PUSH_D_E, POP_D_E, In_SIG_D_E,IN_SIG_M_WB, Protect_D_E, Free_D_E, ALU_SRC_D_E : std_logic;
SIGNAL FLAGS : std_logic_vector(3 DOWNTO 0);
SIGNAL WBOut, MOut : std_logic;
SIGNAL FLAGS_E_M : std_logic_vector(3 DOWNTO 0);
SIGNAL Branch_Sig_E_M, Branch_Z_Sig_E_M: std_logic;
SIGNAL PUSH_E_M, POP_E_M, In_SIG_E_M, Protect_E_M, Free_E_M : std_logic;
SIGNAL WRITE_DATA_E_M : std_logic_vector(31 DOWNTO 0);
SIGNAL MEM_OUTPUT,MEM_OUTPUT_M_WB : std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_OUTPUT_M_WB,IMM_VALUE_D_E : std_logic_vector(31 DOWNTO 0);
SIGNAL WRITEREG : std_logic_vector(31 DOWNTO 0);
SIGNAL temp : std_logic_vector(31 DOWNTO 0);
Signal BRANCH_SIG_IN, BRANCH_Z_SIG_IN : std_logic;
BEGIN

u0: Fetch PORT MAP(CLK, RST, BRANCH_SIG, BRANCH_Z_SIG, Stall, ALU_OUTPUT_E_M, PC_SAVED_1, FetchedInstruction, Swaped_INST, EXTENDED_IMM);
u1: F_D PORT MAP(CLK, RST, stall, FetchedInstruction, PC_SAVED_1, IN_PORT, PREV_STALL_OUT, PC_OUT_F_D, OP_CODE_F_D, SRC1, SRC2, WRITE_ADDRESS_F_D, IN_PORT_F_D);
u2: DecodeUnit PORT MAP(CLK, RST, OP_CODE_F_D, SRC1, SRC2,RegWrite_M_WB ,WriteReg, WRITE_ADDRESS_M_WB, ReadData1, ReadData2, MemtoReg, ALU_Src, RegWrite, MemWrite, Stall, Swap, Branch_Sig_in, Branch_Z_Sig_IN, Push, Pop, In_sig, Protect, Free, Swaped_INST,OUT_PORT);
u3: D_E PORT MAP(CLK, RST, MemToReg,RegWrite, MemWrite, Branch_Sig_in, Branch_Z_Sig_IN, PUSH, POP, In_SIG, Protect, Free, ALU_SRC,PC_OUT_F_D,ReadData1,ReadData2,EXTENDED_IMM,IN_PORT_F_D,WRITE_ADDRESS_F_D,OP_CODE_F_D,MemToReg_D_E,RegWrite_D_E,MemWrite_D_E,Branch_Sig_D_E,Branch_Z_Sig_D_E,PUSH_D_E,POP_D_E,In_SIG_D_E,Protect_D_E,Free_D_E,ALU_SRC_D_E,PC_OUT_D_E,ReadData1_D_E,ReadData2_D_E,IMM_VALUE_D_E,IN_PORT_D_E,WRITE_ADDRESS_D_E,OP_CODE_D_E);
u4: EXECUTE PORT MAP(CLK, RST, ALU_SRC_D_E, OP_CODE_D_E, ReadData1_D_E, ReadData2_D_E, IMM_VALUE_D_E, ALU_OUTPUT, FLAGS);
u5: E_M PORT MAP(CLK, RST, ALU_OUTPUT, PC_OUT_D_E, FLAGS, WRITE_ADDRESS_D_E, IN_PORT_D_E, MemToReg_D_E, RegWrite_D_E, MemWrite_D_E, Branch_Sig_D_E, Branch_Z_Sig_D_E, PUSH_D_E, POP_D_E, In_SIG_D_E, Protect_D_E, Free_D_E,ReadData1_D_E, ALU_OUTPUT_E_M, PC_OUT_E_M, FLAGS_E_M, WRITE_ADDRESS_E_M, IN_PORT_E_M, MemToReg_E_M, RegWrite_E_M, MemWrite_E_M, Branch_Sig_E_M, Branch_Z_Sig_E_M, PUSH_E_M, POP_E_M, In_SIG_E_M, Protect_E_M, Free_E_M,WRITE_DATA_E_M);
u6: MEMORY PORT MAP(CLK, RST, PUSH_E_M, POP_E_M, MemWrite_E_M, ALU_OUTPUT_E_M, WRITE_DATA_E_M, MEM_OUTPUT, FLAGS_E_M, BRANCH_SIG_E_M, BRANCH_Z_SIG_E_M, BRANCH_SIG, BRANCH_Z_SIG);
u7: M_WB PORT MAP(CLK, RST, MemToReg_E_M, RegWrite_E_M, In_SIG_E_M, MEM_OUTPUT, ALU_OUTPUT_E_M, IN_PORT_E_M, WRITE_ADDRESS_E_M, MemToReg_M_WB, RegWrite_M_WB, In_SIG_M_WB, MEM_OUTPUT_M_WB, ALU_OUTPUT_M_WB, IN_PORT_M_WB, WRITE_ADDRESS_M_WB);
u8: Mux2x1 generic map(32) PORT MAP(MEM_OUTPUT_M_WB, ALU_OUTPUT_M_WB, MemToReg_M_WB, temp);
u9: Mux2x1 generic map(32) PORT MAP(temp, IN_PORT_M_WB, In_SIG_M_WB, WRITEREG);


END ARCHITECTURE;