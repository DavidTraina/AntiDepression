vlib work

vlog -timescale 1ns/1ns lifeDrawer.v

vsim lifeDrawer
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0
force {lose_a_life} 0 0, 1 200, 0 202, 1 400, 0 402, 1 600, 0 602
run 800 ns

force {clk}	0 0, 1 1 -r 2
force {enable}	0 0
run 40 ns


