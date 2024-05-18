
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY MAIN_PROCESSOR IS

PORT (
CLK,RST,RESET_SIG,INTERRUPT_SIG:IN std_logic;
IN_PORT: IN std_logic_vector(31 DOWNTO 0);
OUT_PORT: OUT std_logic_vector(31 DOWNTO 0)


);

END ENTITY;


Architecture MAIN of MAIN_PROCESSOR IS

COMPONENT Fetch IS

PORT (
CLK,RST,INTERRUPT_SIG,RESET_SIG,CALL_SIG,RET_SIG,RTI_SIG:IN std_logic;
Branch0: IN std_logic;
BranchU: IN std_logic;
Stall: IN std_logic;
CALL_INSTRUCTION: IN std_logic_vector(31 DOWNTO 0);
RET_INSTRUCTION: IN std_logic_vector(31 DOWNTO 0);
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
CLK,RST,PERV_STALL:IN std_logic;
opcode: IN std_logic_vector(4 DOWNTO 0);
ReadReg1: IN std_logic_vector(2 DOWNTO 0);
ReadReg2: IN std_logic_vector(2 DOWNTO 0);
DST: IN std_logic_vector(2 DOWNTO 0);
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
callSig,retSig,RTI_SIG: OUT STD_LOGIC;
Swaped_INST :OUT std_logic_vector(15 downto 0);
OUT_PORT:OUT std_logic_vector(31 DOWNTO 0);
ReadReg1out,ReadReg2out:OUT std_logic_vector(2 downto 0)--hayrooho 3ala forwarding


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
		INTERRUPT_SIG_OUT: OUT STD_LOGIC;
		ReadReg1in,ReadReg2in:OUT std_logic_vector(2 downto 0);
		ReadReg1out,ReadReg2out:OUT std_logic_vector(2 downto 0)





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
FLAGS: OUT std_logic_vector(3 downto 0);
PREV_FLAGS: OUT std_logic_vector(3 downto 0);
ForwardedData:IN std_logic_vector(31 DOWNTO 0);
Forwardselector1,Forwardselector2:IN std_logic
);

END COMPONENT;

COMPONENT E_M IS
PORT(	CLK, RST: IN STD_LOGIC;
Alu_output: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
PC: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
Flags: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
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
PREV_FLAGS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);


Alu_outputOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
PCOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
FLAGS_Out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
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
CLK,RST,PUSH,POP,MEM_WRITE,INTERRUPT_SIG,MEMTOREG:IN std_logic;
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

component ForwardingUnit IS
    PORT (
        clk : IN STD_LOGIC;
        Src1, Src2, ExDst, MemDst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		MemtoRegE, MemtoRegM : IN STD_LOGIC; 
        ExResultMe, MemResult : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        ForwardedData : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Selector1, Selector2 : OUT STD_LOGIC
    );
END component;
signal ALU_OUTPUT : std_logic_vector(31 downto 0) := (others => '0'); -- ALU output data (32 bits)
signal ALU_OUTPUT_M_WB,IN_PORT_OUT_M_WB: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal ALU_Src: std_logic:= '0';
signal ALU_SRC_D_E : std_logic:= '0'; -- ALU source operand select (2 bits)
signal Alu_outputOut_E_M: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal BRANCH_ADDRESS_M : std_logic_vector(31 downto 0) := (others => '0'); -- Branch address (Memory stage)
signal BRANCH_SIG_M: std_logic:= '0';
signal BRANCH_SIG_OUT,BRANCH_SIG_OUT_D_E,BRANCH_SIG_OUT_E_M: std_logic:= '0';
signal BRANCH_Z_SIG_M: std_logic:= '0';
signal BRANCH_Z_SIG_OUT,BRANCH_Z_SIG_OUT_D_E,BRANCH_Z_SIG_OUT_E_M: std_logic:= '0';
signal CALL_SIG_D: std_logic:= '0';
signal CAll_INSTRUCTION: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal DEST: std_logic_vector(2 DOWNTO 0):= (others => '0');
signal EXTENDED_IMM: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal FLAGS : std_logic_vector(3 downto 0) := (others => '0');        -- Status flags (4 bits)
signal FLAGS_OUT_E_M: std_logic_vector(3 DOWNTO 0):= (others => '0');
signal FETECHED_INSTRUCTION: std_logic_vector(15 DOWNTO 0):= (others => '0');
signal FLUSH_SIG_M: std_logic:= '0';
signal Free : std_logic := '0';           -- Resource management (might be specific to your architecture)
signal Free_OUT_D_E,ALU_SRC_OUT_D_E: std_logic:= '0';
signal IMM_VALUE : std_logic_vector(31 DOWNTO 0):= (others => '0');
signal IMM_VALUE_OUT_D_E: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal IN_PORT_OUT_D_E: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal IN_PORT_OUT_E_M: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal IN_PORT_OUT_F_D: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal IN_PORT_OUT_W_MB: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal Insig : std_logic := '0';          -- Unidentified signal purpose
Signal In_SIG,in_sig_out_M_WB : std_Logic:= '0';
signal INTERRUPT_SIG_out_F_D,INTERRUPT_SIG_out_E_M,INTERRUPT_SIG_out_D_E: std_logic:= '0';
signal MemToReg : std_logic := '0';  -- Whether to send ALU output to register file
signal MemToReg_OUT_D_E,RegWrite_OUT_D_E,MemWrite_OUT_D_E,PUSH_OUT_D_E,POP_OUT_D_E,In_SIG_OUT_D_E,Protect_OUT_D_E: std_logic:= '0';
signal MemToReg_OUT_M_WB,RegWrite_OUT_M_WB: std_logic:= '0';
signal MemToReg_Out_E_M,RegWrite_Out_E_M,MemWrite_Out_E_M,PUSH,POP,PUSH_Out_E_M,POP_Out_E_M,In_SIG_Out_E_M,Protect_Out_E_M,Free_Out_E_M: std_logic:= '0';
signal MemWrite : std_logic := '0';  -- Enable writing to memory
signal MEM_OUTPUT: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal MEM_OUTPUT_M_WB: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal OP_CODE: std_logic_vector(4 DOWNTO 0):= (others => '0');
signal OP_CODE_D_E: std_logic_vector(4 DOWNTO 0):= (others => '0');
signal Out1,Out2: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal PC_OUT_D_E,PC_OUT_E_M,PC_OUT_W_MB: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal PC_OUT_F_D: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal PC_SAVED: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal PREV_FLAGS : std_logic_vector(3 downto 0) := (others => '0');    -- Previous flags register
signal PREV_FLAGS_E_M: std_logic_vector(3 DOWNTO 0):= (others => '0');
signal PREV_STALL_OUT: std_logic:= '0';
signal Protect : std_logic := '0';        -- Memory protection (might be specific to your architecture)
signal ReadData1,ReadData2: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal ReadData1_OUT_D_E,ReadData2_OUT_D_E: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal RegWrite : std_logic := '0';  -- Enable writing to register file

signal RET_SIG_M : std_logic := '0'; -- Return from subroutine (Memory stage)
signal RET_SIG_OUT_D_E,RET_SIG_out_E_M,RET_SIG_OUT_M: std_logic:= '0';
signal RET_SIG_out : std_logic := '0'; -- Return from subroutine signal (generated)
signal RTI_FLAGS_M : std_logic_vector(3 downto 0) := (others => '0'); -- Return from interrupt flags (Memory stage)
signal RTI_SIG_M : std_logic := '0'; -- Return from interrupt (Memory stage)
signal RTI_SIG_OUT_D_E,RTI_SIG_out_E_M,RTI_SIG_OUT_M: std_logic:= '0';
signal RTI_SIG_OUT : std_logic := '0'; -- Return from interrupt signal (external)
signal SRC1,SRC2: std_logic_vector(2 DOWNTO 0):= (others => '0');
signal STALL : std_logic := '0';     -- Pipeline stall signal
signal Swap : std_logic := '0';          -- Data swap operation (less common)
signal Swaped_INST: std_logic_vector(15 DOWNTO 0):= (others => '0');
signal Write_Address_OUT: std_logic_vector(2 DOWNTO 0):= (others => '0');
signal Write_Address_OUT_M_WB: std_logic_vector(2 DOWNTO 0):= (others => '0');
signal WriteAddress_Out_E_M: std_logic_vector(2 DOWNTO 0):= (others => '0');
signal WRITE_ADDRESS_OUT_D_E: std_logic_vector(2 DOWNTO 0):= (others => '0');
signal Write_data_out_E_M: std_logic_vector(31 DOWNTO 0):= (others => '0');
signal Write_data_out_D_E : std_logic_vector(31 downto 0) := (others => '0'); -- Data to be written to memory
signal callSig_out : std_logic := '0'; -- Subroutine call signal (generated)
signal callSig_out_D_E: std_logic:= '0';
signal callSig_out_E_M: std_logic:= '0';
signal call_Sig_out_D_E : std_logic := '0'; -- Subroutine call signal (generated)
signal RESET_ALL: std_logic := '0'; -- Reset all signals
SIGNAL ReadReg1F,ReadReg2F: std_logic_vector(2 downto 0);--ignore do nothing
SIGNAL FORWARDED: std_logic_vector(31 DOWNTO 0);
SIGNAL FRWDSELEC1,FRWDSELEC2: std_logic;
signal readreg1_D_E,readreg2_D_E: std_logic_vector(2 DOWNTO 0);


BEGIN
RESET_ALL <= RST OR FLUSH_SIG_M;
u0: FETCH PORT MAP(CLK,RST,INTERRUPT_SIG,RST,CALL_SIG_D,RET_SIG_M,RTI_SIG_M,BRANCH_SIG_M, BRANCH_Z_SIG_M,STALL,CALL_INSTRUCTION,MEM_OUTPUT,BRANCH_ADDRESS_M,PC_SAVED,FETECHED_INSTRUCTION,Swaped_INST,EXTENDED_IMM);
u1: F_D PORT MAP(CLK, RESET_ALL, STALL, FETECHED_INSTRUCTION, PC_SAVED, IN_PORT, INTERRUPT_SIG, PREV_STALL_OUT, PC_OUT_F_D, OP_CODE, SRC1, SRC2, WRITE_ADDRESS_OUT, IN_PORT_OUT_F_D, INTERRUPT_SIG_OUT_F_D);
u2: DecodeUnit PORT MAP(CLK, RST,PREV_STALL_OUT, OP_CODE, SRC1, SRC2,WRITE_ADDRESS_OUT, RegWrite_OUT_M_WB, Out2, Write_Address_OUT_M_WB, ReadData1, ReadData2, MemtoReg, ALU_Src, RegWrite, MemWrite, Stall, Swap, Branch_SIG_OUT, BRANCH_Z_SIG_OUT, Push, Pop, In_sig, Protect, Free, callSig_out, RET_SIG_out,RTI_SIG_OUT, Swaped_INST, OUT_PORT,ReadReg1F,ReadReg2F);
u3: D_E PORT MAP(CLK, RESET_ALL, MemToReg, RegWrite, MemWrite, Branch_SIG_OUT, BRANCH_Z_SIG_OUT, PUSH, POP, In_SIG, Protect, Free, ALU_SRC, PC_OUT_F_D, ReadData1, ReadData2, EXTENDED_IMM, IN_PORT_OUT_F_D, WRITE_ADDRESS_OUT, OP_CODE, callSig_out, RET_SIG_out, RTI_SIG_OUT, INTERRUPT_SIG_out_F_D,MemToReg_OUT_D_E,RegWrite_OUT_D_E,MemWrite_OUT_D_E,Branch_Sig_OUT_D_E,Branch_Z_Sig_OUT_D_E,PUSH_OUT_D_E,POP_OUT_D_E,In_SIG_OUT_D_E,Protect_OUT_D_E,Free_OUT_D_E,ALU_SRC_OUT_D_E, PC_OUT_D_E, ReadData1_OUT_D_E, ReadData2_OUT_D_E, IMM_VALUE_OUT_D_E, IN_PORT_OUT_D_E, WRITE_ADDRESS_OUT_D_E, OP_CODE_D_E, callSig_out_D_E, RET_SIG_out_D_E, RTI_SIG_out_D_E, INTERRUPT_SIG_out_D_E,ReadReg1F,ReadReg1F,readreg1_D_E,readreg2_D_E);
u4: EXECUTE PORT MAP(CLK, RST, ALU_SRC_OUT_D_E, OP_CODE_D_E, ReadData1_OUT_D_E, ReadData2_OUT_D_E, IMM_VALUE_OUT_D_E, RTI_SIG_out_E_M, RTI_FLAGS_M, ALU_OUTPUT, FLAGS,PREV_FLAGS,FORWARDED,FRWDSELEC1,FRWDSELEC2);
u5: E_M PORT MAP(CLK,RESET_ALL, ALU_OUTPUT, PC_OUT_D_E, FLAGS, WRITE_ADDRESS_OUT_D_E, IN_PORT_OUT_D_E, MemToReg_Out_D_E, RegWrite_Out_D_E, MemWrite_Out_D_E, Branch_Sig_Out_D_E, Branch_Z_Sig_Out_D_E, PUSH_OUT_D_E, POP_OUT_D_E, In_SIG_OUT_D_E, Protect_OUT_D_E, Free_OUT_D_E, Write_data_out_D_E, call_Sig_out_D_E, RET_SIG_out_D_E, RTI_SIG_out_D_E, INTERRUPT_SIG_out_D_E,PREV_FLAGS, ALU_outputOut_E_M, PC_OUT_E_M,FLAGS_OUT_E_M ,PREV_FLAGS_E_M, WriteAddress_Out_E_M, IN_PORT_OUT_E_M, MemToReg_Out_E_M, RegWrite_Out_E_M, MemWrite_Out_E_M, Branch_Sig_Out_E_M, Branch_Z_Sig_Out_E_M, PUSH_Out_E_M, POP_Out_E_M, In_SIG_Out_E_M, Protect_Out_E_M, Free_Out_E_M, Write_data_out_E_M, callSig_out_E_M, RET_SIG_out_E_M, RTI_SIG_out_E_M, INTERRUPT_SIG_out_E_M);
u6: MEMORY PORT MAP(CLK, RST, PUSH_OUT_E_M, POP_OUT_E_M, MEMWRITE_OUT_E_M, INTERRUPT_SIG_OUT_E_M,MEMTOREG_OUT_E_M, ALU_outputOut_E_M, Write_data_out_E_M, MEM_OUTPUT, FLAGS_OUT_E_M, Branch_Sig_out_E_M, Branch_Z_Sig_out_E_M, Protect_OUT_E_M, Free_OUT_E_M, PC_OUT_E_M, callSig_out_E_M, RET_SIG_out_E_M, RTI_SIG_out_E_M, RET_SIG_OUT_M, RTI_SIG_OUT_M, BRANCH_SIG_M, BRANCH_Z_SIG_M, FLUSH_SIG_M, RTI_FLAGS_M);
u7: M_WB PORT MAP(CLK, RST, MemToReg_Out_E_M, RegWrite_Out_E_M, In_SIG_OUT_E_M, MEM_OUTPUT, ALU_outputOut_E_M, IN_PORT_OUT_E_M, WriteAddress_Out_E_M, MemToReg_OUT_M_WB, RegWrite_OUT_M_WB, In_SIG_OUT_M_WB, MEM_OUTPUT_M_WB, ALU_OUTPUT_M_WB, IN_PORT_OUT_M_WB, Write_Address_OUT_M_WB);
u10: ForwardingUnit PORT MAP(CLK,readreg1_D_E,readreg2_D_E,WRITE_ADDRESS_OUT_D_E,WriteAddress_Out_E_M,MemToReg_Out_E_M,MemToReg_OUT_M_WB,ALU_outputOut_E_M,MEM_OUTPUT_M_WB,FORWARDED,FRWDSELEC1,FRWDSELEC2);
u8: Mux2x1 generic map(32) PORT MAP( MEM_OUTPUT_M_WB,ALU_OUTPUT_M_WB, MEMTOREG_OUT_M_WB, Out1);
u9: Mux2x1 generic map(32) PORT MAP(Out1, IN_PORT_OUT_M_WB,IN_SIG_OUT_M_WB, Out2);


END ARCHITECTURE;