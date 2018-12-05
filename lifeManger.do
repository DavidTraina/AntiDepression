vlib work

vlog -timescale 1ns/1ns lifeManager.v

vsim lifeManager
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0
force {input_key} 0 0, 1 78 -r 80
run 3000 ns

force {clk}	0 0, 1 1 -r 2
force {enable}	0 0
run 40 ns


