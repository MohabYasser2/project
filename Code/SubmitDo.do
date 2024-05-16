vsim -gui work.main_processor
# vsim -gui work.main_processor 
# Start time: 04:36:08 on Apr 25,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.main_processor(main)
# Loading work.fetch(fetchunit)
# Loading work.pc(pc_arch)
# Loading work.mux2x1(arch1)
# Loading work.instruction_cache(arch)
# Loading work.f_d(fdregarch)
# Loading work.decodeunit(arch)
# Loading work.controlunit(arch)
# Loading work.registerfile32(arch)
# Loading work.d_e(fdregarch)
# Loading work.execute(fetchunit)
# Loading work.alu(archd_1)
# Loading work.ccr(ccr_arch)
# Loading work.e_m(fdregarch)
# Loading work.memory(fetchunit)
# Loading work.datamemory(arch)
# Loading work.sp(sp_arch)
# Loading work.inc_dec(sp_arch)
# Loading work.m_wb(fdregarch)
# ** Warning: (vsim-8683) Uninitialized out port /main_processor/u2/u0/Swap_INST(15 downto 0) has no driver.
# This port will contribute value (UUUUUUUUUUUUUUUU) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /main_processor/u6/U1/DATAOUT(31 downto 0) has no driver.
# This port will contribute value (UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU) to the signal network.
add wave -position end  sim:/main_processor/CLK
add wave -position end  sim:/main_processor/RST
add wave -position end  sim:/main_processor/u0/PC_OUT
add wave -position end  sim:/main_processor/u2/u1/RAM
force -freeze sim:/main_processor/Swaped_INST 0000000000000000 0
force -freeze sim:/main_processor/BRANCH_SIG 0 0
force -freeze sim:/main_processor/BRANCH_Z_SIG 0 0
add wave -position end  sim:/main_processor/FLAGS
force -freeze sim:/main_processor/RST 1 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 1  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 1  Instance: /main_processor/u2/u1
mem load -filltype value -filldata 1000000000000000 -fillradix symbolic /main_processor/u0/U2/RAM(0)
mem load -filltype value -filldata 1001100000000000 -fillradix symbolic /main_processor/u0/U2/RAM(1)
mem load -filltype value -filldata 0000000000000001 -fillradix symbolic /main_processor/u0/U2/RAM(2)
mem load -filltype value -filldata 1001100000000100 -fillradix symbolic /main_processor/u0/U2/RAM(3)
mem load -filltype value -filldata 1010101010101010 -fillradix symbolic /main_processor/u0/U2/RAM(4)
mem load -filltype value -filldata 1001100000001000 -fillradix symbolic /main_processor/u0/U2/RAM(5)
mem load -filltype value -filldata 1111111111111111 -fillradix symbolic /main_processor/u0/U2/RAM(6)
mem load -filltype value -filldata 0010000000000000 -fillradix symbolic /main_processor/u0/U2/RAM(7)
mem load -filltype value -filldata 0011100100010000 -fillradix symbolic /main_processor/u0/U2/RAM(8)
mem load -filltype value -filldata 0000100100000100 -fillradix symbolic /main_processor/u0/U2/RAM(9)
mem load -filltype value -filldata 0011100000001100 -fillradix symbolic /main_processor/u0/U2/RAM(10)
mem load -filltype value -filldata 0010000000000000 -fillradix symbolic /main_processor/u0/U2/RAM(11)
mem load -filltype value -filldata 1000010001000000 -fillradix symbolic /main_processor/u0/U2/RAM(12)
mem load -filltype value -filldata 0111000110010100 -fillradix symbolic /main_processor/u0/U2/RAM(13)
mem load -filltype value -filldata 0011100000011000 -fillradix symbolic /main_processor/u0/U2/RAM(14)
mem load -filltype value -filldata 1000001010000000 -fillradix symbolic /main_processor/u0/U2/RAM(15)
mem load -filltype value -filldata 1000010100000000 -fillradix symbolic /main_processor/u0/U2/RAM(16)
mem load -filltype value -filldata 0111010001111100 -fillradix symbolic /main_processor/u0/U2/RAM(17)
mem load -filltype value -filldata 0000111000011000 -fillradix symbolic /main_processor/u0/U2/RAM(18)
mem load -filltype value -filldata 0010000000000000 -fillradix symbolic /main_processor/u0/U2/RAM(19)
force -freeze sim:/main_processor/RST 0 0
force -freeze sim:/main_processor/CLK 1 0, 0 {50 ps} -r 100
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run