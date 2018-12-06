vlib work

vlog -timescale 1ns/1ns random.v

vsim random
log {/*}

add wave {/*}

force {clk}	1'b0 0, 1'b1 1 -r 2
force {resetn}	1'b1 0, 1'b0 2, 1'b1 4
run 50ns



