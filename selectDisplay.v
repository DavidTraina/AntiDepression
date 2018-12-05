module selectDisplay(clk, resetn, enable, input_key, startscreen_done, grid_done, game_done, display_sel_out);
	input 			clk, resetn, enable, input_key; 		//input_key used to start game / restart game 
	input			startscreen_done, grid_done, game_done;		//flags to signal that drawing has finished
	reg		[2:0]	current_state, next_state; 			//3 bits since there are 5 states
	output	reg	[2:0]	display_sel_out;

	//5 states
	localparam	STARTSCREEN		= 3'd0,
			STARTSCREEN_ERASE	= 3'd1,
			DRAW_GRID		= 3'd2,
			PLAY_GAME		= 3'd3,
			ENDSCREEN		= 3'd4;

	//State Table
	always@(*)
	begin: state_table
		case (current_state)
			STARTSCREEN:		next_state = input_key ? STARTSCREEN_ERASE : STARTSCREEN; //if input_key == true then STARTSCREEN_ERASE, else: STARTSCREEN
			STARTSCREEN_ERASE:	next_state = startscreen_done ? DRAW_GRID : STARTSCREEN_ERASE;
			DRAW_GRID:		next_state = grid_done ? PLAY_GAME : DRAW_GRID;
			PLAY_GAME:		next_state = game_done ? ENDSCREEN : PLAY_GAME;
			ENDSCREEN:		next_state = input_key ? STARTSCREEN : ENDSCREEN;
			default: 		next_state = STARTSCREEN;
		endcase
	end

	//State Outputs
	always@(*)
	begin: enable_signals
		case(current_state)
			STARTSCREEN: 		display_sel_out = 3'd0;
			STARTSCREEN_ERASE: 	display_sel_out	= 3'd1;
			DRAW_GRID:		display_sel_out	= 3'd2;
			PLAY_GAME:		display_sel_out = 3'd3;
			ENDSCREEN:		display_sel_out = 3'd4;
			default: display_sel_out = 3'd0;
		endcase
	end

    	always@(posedge clk)
    	begin: state_FFs
        	if(!resetn)
            		current_state <= STARTSCREEN;
        	else
            		current_state <= next_state;
    	end

endmodule

module displayEnable(display_sel_out, startscreen_en, startscreen_erase_en, grid_en, play_game_en, endscreen_en);
	input	[2:0]	display_sel_out;
	output		startscreen_en, startscreen_erase_en, grid_en, play_game_en, endscreen_en;

	assign startscreen_en 		= (display_sel_out[2:0] == 3'd0);
	assign startscreen_erase_en 	= (display_sel_out[2:0] == 3'd1);
	assign grid_en			= (display_sel_out[2:0] == 3'd2);
	assign play_game_en		= (display_sel_out[2:0] == 3'd3);
	assign endscreen_en		= (display_sel_out[2:0] == 3'd4);

endmodule

