vlib work

vlog -timescale 1ns/1ns selectDisplay.v

vsim selectDisplay
log {/*}

add wave {/*}

force {clk}	0 0, 1 1 -r 2
force {resetn}	1 0, 0 2, 1 4
force {enable}	1 0
force {input_key} 0 0, 1 50, 0 52, 1 90, 0 92
force {startscreen_done} 0 0, 1 60, 0 62
force {grid_done} 0 0, 1 70, 0 72
force {game_done} 0 0, 1 80, 0 82
run 150 ns




