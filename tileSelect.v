module tileSelect(clk, resetn, enable, pause, location_out);
	input 			clk, resetn, enable, pause;
	output reg	[3:0]	location_out;
	reg		[4:0]	current_state, next_state;
	wire			rate_out;

	rateDivider r0(clk, resetn, rate_out);

	localparam	TILE_0	= 4'd0,
			TILE_1	= 4'd1,
			TILE_2	= 4'd2,
			TILE_3	= 4'd3,
			TILE_4	= 4'd4,
			TILE_5	= 4'd5,
			TILE_6	= 4'd6,
			TILE_7	= 4'd7,	
			TILE_8	= 4'd8;

	always@(*)
	begin: state_table
		case (current_state)
			TILE_0:	next_state = rate_out ? TILE_1 : TILE_0;
			TILE_1:	next_state = rate_out ? TILE_2 : TILE_1;
			TILE_2:	next_state = rate_out ? TILE_3 : TILE_2;
			TILE_3:	next_state = rate_out ? TILE_4 : TILE_3;
			TILE_4:	next_state = rate_out ? TILE_5 : TILE_4;
			TILE_5:	next_state = rate_out ? TILE_6 : TILE_5;
			TILE_6:	next_state = rate_out ? TILE_7 : TILE_6;
			TILE_7:	next_state = rate_out ? TILE_8 : TILE_7;
			TILE_8: next_state = rate_out ? TILE_0 : TILE_8;
			default: next_state = TILE_0;
		endcase
	end

	always@(*)
	begin: enable_signals
		location_out = 4'd0;
		case(current_state)
			TILE_0: location_out = 4'd0;
			TILE_1: location_out = 4'd1;
			TILE_2: location_out = 4'd2;
			TILE_3: location_out = 4'd3;
			TILE_4: location_out = 4'd4;
			TILE_5: location_out = 4'd5;
			TILE_6: location_out = 4'd6;
			TILE_7: location_out = 4'd7;
			TILE_8: location_out = 4'd8;
			default: location_out = 4'd0;
		endcase
	end

    	always@(posedge clk)
    	begin: state_FFs
        	if(!resetn)
            		current_state <= TILE_0;
		else if (pause)
			current_state <= current_state;
        	else
            		current_state <= next_state;
    	end

endmodule

module rateDivider(clock_in, resetn, clock_out);
	input		clock_in, resetn;
	output		clock_out;
	reg	[6:0]	count;

	always @(posedge clock_in)
	begin
		if(resetn == 1'b0)
			count <= 0;
		else if (count == 0)
			count <= 7'd100;
		else
			count <= count - 1'b1;
	end
	
	assign clock_out = ~|count[7:0];

endmodule

