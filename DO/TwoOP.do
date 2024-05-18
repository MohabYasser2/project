restart -f
force -freeze sim:/main_processor/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/main_processor/RST 1 0
mem load -i {C:/Users/mohab/Desktop/Uni/Courses/Year 3 - 2nd term/Computer Arch/Project/Code/project/Test_Cases/MOHAB_TEST.mem} /main_processor/u0/U2/INSTRUCTION_CACHE
run
# Loading work.main_processor(main)
# Loading work.fetch(fetchunit)
# Loading work.pc(pc_arch)
# Loading work.mux4x1(arch1)
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
# Loading work.forwardingunit(forwarding)
# Loading work.branchpredictionunit(bracnchpred)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 1  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 1  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /main_processor/u0/U2
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /main_processor/u0/U2
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /main_processor/u0/U2
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 100 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 100 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 100 ps  Iteration: 0  Instance: /main_processor/u6/U1
force -freeze sim:/main_processor/RST 0 0
force -freeze sim:/main_processor/IN_PORT 00000000000000000000000000000101 0
run
force -freeze sim:/main_processor/IN_PORT 00000000000000000000000000011001 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 250 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 250 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 250 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 250 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 250 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 250 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 300 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 300 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 300 ps  Iteration: 0  Instance: /main_processor/u6/U1
force -freeze sim:/main_processor/IN_PORT 11111111111111111111111111111111 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 350 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 350 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 350 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 350 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 350 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 350 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 400 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 400 ps  Iteration: 0  Instance: /main_processor/u6/U1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 400 ps  Iteration: 0  Instance: /main_processor/u6/U1
force -freeze sim:/main_processor/IN_PORT 11111111111111111111001100100000 0
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
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 2200 ps  Iteration: 1  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 2200 ps  Iteration: 1  Instance: /main_processor/u2/u1
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 2250 ps  Iteration: 1  Instance: /main_processor/u2/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 2250 ps  Iteration: 1  Instance: /main_processor/u2/u1
run
