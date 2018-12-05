vlib work

vlog -timescale 1ns/1ns faceDrawer.v

vsim faceDrawer
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0
force {location} 3'b000 0, 3'b001 2700, 3'b010 6000
force {colour_in} 3'b111 0
run 7000 ns


force {clk}	0 0, 1 1 -r 2
force {resetn}	0 0, 1 5
force {enable}	1 0, 0 10
run 30 ns


