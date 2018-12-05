module tile(clk, resetn, enable, input_key, lose_a_life, colour_out);
	input			clk, resetn, enable, input_key;
	output	reg	[2:0]	colour_out;
	output	reg		lose_a_life;
	reg		[4:0]	current_state, next_state;
	reg		[23:0]	count;
	reg			counter_start;
	wire			counter_finished;
	reg		[23:0]	random_count;
	reg			random_counter_start;
	wire			random_counter_finished;
	reg		[1:0]	random;

	localparam	START			= 4'd0,
			START_WAIT		= 4'd1,
			DRAW_RED		= 4'd2,
			DRAW_RED_WAIT		= 4'd3,
			DRAW_RED_CLEAR		= 4'd4,
			DRAW_RED_TIMEOUT	= 4'd5,
			DRAW_YELLOW		= 4'd6,
			DRAW_YELLOW_WAIT	= 4'd7,	
			DRAW_YELLOW_CLEAR	= 4'd8,
			DRAW_YELLOW_TIMEOUT	= 4'd9;

	always@(posedge clk)
	begin
		if(resetn == 1'b0)
			count <= 0;
		else if (enable)
			begin
				random[1:0] <= $urandom_range(3);
				if (counter_start)
					count <= 24'd30; // TODO Enter 12,500,000 for 3 seconds
				else
					count <= count - 1'b1;
				if (random_counter_start)
					random_count <= $urandom_range(20);//TODO
				else
					random_count <= random_count - 1'b1;
			end
	end

	assign random_counter_finished = ~|random_count[23:0];
	assign counter_finished = ~|count[23:0];

	always@(*)
	begin: state_table
		case (current_state)
			START:	next_state = START_WAIT;
			START_WAIT: begin
				if (random_counter_finished)
					next_state = &random[1:0] ? DRAW_YELLOW : DRAW_RED;
				else 
					next_state = START_WAIT;
				end
			DRAW_RED: next_state = DRAW_RED_WAIT;
			DRAW_RED_WAIT: begin
				if (input_key)
					next_state = DRAW_RED_CLEAR;
				else if (counter_finished)
					next_state = DRAW_RED_TIMEOUT;
				else
					next_state = DRAW_RED_WAIT;
				end
			DRAW_RED_CLEAR: next_state = START;
			DRAW_RED_TIMEOUT: next_state = START;
			DRAW_YELLOW: next_state = DRAW_YELLOW_WAIT;
			DRAW_YELLOW_WAIT: begin
				if (input_key)
					next_state = DRAW_YELLOW_CLEAR;
				else if (counter_finished)
					next_state = DRAW_YELLOW_TIMEOUT;
				else
					next_state = DRAW_YELLOW_WAIT;
				end
			DRAW_YELLOW_CLEAR: next_state = START;
			DRAW_YELLOW_TIMEOUT: next_state = START;
			default: next_state = START;
		endcase
	end

	always@(*)
	begin: enable_signals
		colour_out = 3'b000;
		counter_start = 1'b0;
		random_counter_start = 1'b0;
		lose_a_life = 1'b0;
		case(current_state)
			START:			random_counter_start = 1'b1;

			DRAW_RED:		begin
						colour_out = 3'b100;
						counter_start = 1'b1;
						end

			DRAW_RED_WAIT:		colour_out = 3'b100;

			DRAW_RED_TIMEOUT:	lose_a_life = 1'b1;

			DRAW_YELLOW:		begin		
						colour_out = 3'b110;
						counter_start = 1'b1;
						end

			DRAW_YELLOW_WAIT:	colour_out = 3'b110;
		
			DRAW_YELLOW_CLEAR:	lose_a_life = 1'b1;

			default:
				begin
				colour_out = 3'b000;
				counter_start = 1'b0;
				random_counter_start = 1'b0;
				lose_a_life = 1'b0;
				end
		endcase
	end

    	always@(posedge clk)
    	begin: state_FFs
        	if(resetn == 0)
            		current_state <= START;
        	else
            		current_state <= next_state;
    	end
endmodule

