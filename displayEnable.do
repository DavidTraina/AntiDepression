vlib work

vlog -timescale 1ns/1ns selectDisplay.v

vsim displayEnable
log {/*}

add wave {/*}

force {display_sel_out}	3'b000 0, 3'b001 10, 3'b010 20, 3'b011 30, 3'b100 40
run 50ns



