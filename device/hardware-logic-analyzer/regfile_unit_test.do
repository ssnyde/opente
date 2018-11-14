vsim work.testrunner
# vsim work.testrunner 
# Start time: 15:37:09 on Nov 14,2018
# Loading sv_std.std
# Loading work.svunit_pkg
# Loading work.testrunner
# Loading work.__testsuite
# Loading work.regfile_unit_test
# Loading work.regfile
add wave -r sim:/testrunner/__ts/regfile_ut/*
run
# INFO:  [0][__ts]: Registering Unit Test Case regfile_ut
# INFO:  [0][testrunner]: Registering Test Suite __ts
# INFO:  [0][__ts]: RUNNING
# INFO:  [0][regfile_ut]: RUNNING
# INFO:  [0][regfile_ut]: zero_after_reset::RUNNING
# INFO:  [63][regfile_ut]: zero_after_reset::PASSED
# INFO:  [63][regfile_ut]: write_addr_0_read_back::RUNNING
