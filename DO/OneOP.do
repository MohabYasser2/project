restart -f
# Loading work.forwardingunit(forwarding)
force -freeze sim:/main_processor/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/main_processor/RST 1 0
mem load -i {C:/Users/mohab/Desktop/Uni/Courses/Year 3 - 2nd term/Computer Arch/Project/Code/project/Test_Cases/MOHAB_TEST.mem} /main_processor/u0/U2/INSTRUCTION_CACHE
run
force -freeze sim:/main_processor/RST 0 0
run
run
run
force -freeze sim:/main_processor/IN_PORT 00000000000000000000000000000101 0
run
force -freeze sim:/main_processor/IN_PORT 00000000000000000000000000010000 0
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


