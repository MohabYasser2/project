LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY controlunit IS

PORT (
CLK, RST : IN std_logic;
OPCODE : IN std_logic_vector(4 DOWNTO 0);
OGInstruction:IN  std_logic_vector(15 downto 0);
Src,DST:IN std_logic_vector(2 downto 0);
--control signals--
--MemtoReg chooses between memory output and Alu output--
--AluSrc chooses wether 2nd operand of Alu is RegSrc2 or ImmValue--
--RegWrite wether operation writes in register file or not--
--MemRead wether operation reads from memory--
--MemRead wether operation writes from memory--
MemtoReg, ALUSrc,RegWrite : OUT std_logic;
MemWrite: OUT std_logic;
Stall,Swap,Branch0,BranchU: OUT std_logic;
Push,Pop,Insig,Outsig: OUT std_logic;
Protect,Free: OUT std_logic;
Swap_INST:OUT std_logic_vector(15 downto 0)



);

END ENTITY;

Architecture Arch of controlunit is
Signal control :std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
Begin


process(clk) IS
BEGIN

	IF(opcode="00000") THEN --NoOp

	control<="0000000000000000";

	END IF;
	IF(opcode="00001") THEN --NOT

	control<="1010000000000000";

	END IF;
	IF(opcode="00100") THEN --DEC

	control<="1010000000000000";

	END IF;
	IF(opcode="01110") THEN --OR

	control<="1010000000000000";

	END IF;
	IF(opcode="10011") THEN --LDM
	--fakes el swap control signal just use stall and inject either NOP OR swapped

	control<="1110100000000000";
	Swap_INST<="0000000000000000";
	END IF;
	IF(opcode="00111") THEN --MOV

	control<="1010000000000000";

	END IF;	
	IF(opcode="10000") THEN --CMP

	control<="0000000000000000";

	END IF;

IF(opcode="00010") THEN --NEG
    control<="10100000000000";
END IF;
IF(opcode="00011") THEN --INC
    control<="1010000000000000";
END IF;
IF(opcode="01000") THEN --SWAP
    control<="10101100000000";
Swap_INST<=OGInstruction(15 downto 10) & OGInstruction(3 downto 1) &OGInstruction(6 downto 4)&OGInstruction(9 downto 7)&OGInstruction(1 downto 0);
END IF;
IF(opcode="01001") THEN --ADD
    control<="10100000000000";
END IF;
IF(opcode="01010") THEN --ADDI
    control<="11100000000000";
END IF;
IF(opcode="01011") THEN --SUB
    control<="10100000000000";
END IF;
IF(opcode="01100") THEN --SUBI
    control<="11100000000000";
END IF;
IF(opcode="01101") THEN --AND
    control<="10100000000000";
END IF;
IF(opcode="01111") THEN --XOR
    control<="10100000000000";
END IF;
IF(opcode="10001") THEN --PUSH
    control<="00010000100000";
END IF;
IF(opcode="10010") THEN --POP
    control<="00100000010000";
END IF;
IF(opcode="10100") THEN --LDD
    control<="01101000000000";
Swap_INST<="00000000000000000000000000000000";
END IF;
IF(opcode="10101") THEN --STD 
    control<="01011000000000";
Swap_INST<="00000000000000000000000000000000";
END IF;
IF(opcode="10110") THEN --PROTECT
    control<="0000000000000000";
END IF;
IF(opcode="10111") THEN --FREE
    control<="0000000000000000";
END IF;
IF(opcode="11000") THEN --JZ
    control<="0000000000000000";
END IF;
IF(opcode="11001") THEN --JMP
    control<="0000000000000000";
END IF;
IF(opcode="11010") THEN --CALL
    control<="0000000000000010";
END IF;
IF(opcode="11011") THEN --RET
    control<="0000000000000000";
END IF;
IF(opcode="11100") THEN --RTI
    control<="0000000000000000";
END IF;
IF(opcode="11101") THEN --RESET
    control<="0000000000000000";
END IF;


END PROCESS;
MemtoReg<=control(15);
ALUSrc<=control(14);
RegWrite<=control(13 );
MemWrite<=control(12 );
Stall<=control(11 );
Swap<=control(10 );
Branch0<=control(9 );
BranchU<=control(8 );
Push<=control(7 );
Pop<=control(6);
Insig<=control(5);
Outsig<=control(4);
Protect<=control(3);
Free<=control(2);
call<=control(1);

END ARCHITECTURE;
