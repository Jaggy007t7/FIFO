set_attr lib_search_path ./lib
set_attr library FreePDK45_lib_v1.0_typical.lib

read_hdl -language verilog fifo.v
elaborate fifo

# These are the conditions at which the design operates;
read_sdc const.sdc
set_load 0.05 [all_outputs]
set_input_transition 0.1 [all_inputs]
set_max_delay 1.4 -from [all_inputs] -to [all_outputs]

syn_generic -effort high
syn_map -effort high
syn_opt -effort high

report area > fifo_area.log
report power > fifo_power.log
report timing > fifo_timing.log

write_hdl > counter_netlist.v
exit
