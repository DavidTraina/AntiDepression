module lifeManager(clk, resetn, enable, lose_a_life, idle, game_over, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable, lose_a_life;
	output			idle, game_over;
	output	reg	[7:0]	x_out;
	output	reg	[6:0]	y_out;
	output		[2:0]	colour_out;
	output	reg		write_out;
	reg			draw_lives;

endmodule

module lifeDrawer(clk, resetn, enable, lose_a_life, game_over, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable, lose_a_life;
	output			game_over;
	output	reg	[7:0]	x_out;
	output	reg	[6:0]	y_out;
	output		[2:0]	colour_out;
	output	reg		write_out;
