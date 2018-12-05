vlib work

vlog -timescale 1ns/1ns gridDrawer.v

vsim gridDrawer
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0
run 3000 ns

force {clk}	0 0, 1 1 -r 2
force {enable}	1 0, 0 10, 1 20
run 300 ns


