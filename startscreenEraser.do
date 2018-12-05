vlib work

vlog -timescale 1ns/1ns screenDisplays.v

vsim startscreenEraser
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0, 0 384500, 1 384600
run 385000 ns


