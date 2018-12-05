vlib work

vlog -timescale 1ns/1ns tileSelect.v

vsim tileSelect
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0
force {pause}	0 1, 1 550, 0 650, 1 1150, 0 1250 
run 3000 ns




