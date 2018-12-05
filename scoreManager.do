vlib work

vlog -timescale 1ns/1ns scoreManager.v

vsim scoreManager
log {/*}

add wave {/*}
 
#value StartTime, value nextTime, ..., value lastTime -r repeatTime

force {clk}	1'b0 0, 1'b1 1 -r 2
force {enable}  1'b1 0
force {resetn}  1'b0 0, 1'b1 2
force {increase_score} 1'b0 0, 1'b1 10, 1'b0 20


run 50ns

 
