module lifeDrawer(clk, resetn, enable, lose_a_life, active, game_over, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable, lose_a_life;
	output	reg		active, game_over;
	output	reg	[7:0]	x_out;
	output	reg	[6:0]	y_out;
	output	reg	[2:0]	colour_out;
	output	reg		write_out;
	reg		[1:0]	life_counter;
	reg			starting;
	reg			currently_erasing;


	always@(posedge clk)
	begin
		if (!resetn)
			begin
			life_counter 		<= 2'd3;
			x_out 			<= 8'd146;
			y_out 			<= 7'd87;
			colour_out 		<= 3'b111;
			write_out		<= 1'b1;
			starting		<= 1'b1;
			currently_erasing 	<= 1'b0;
			game_over		<= 1'b0;
			active			<= 1'b1;		
			end
		else if (enable && starting)
			begin
			if (x_out == 8'd149)
				begin
				if (y_out == 7'd98)
					begin
					starting <= 1'b0;
					write_out <= 1'b0;
					active	<= 1'b0;	
					end
				else
					begin
					x_out <= 8'd146;
					y_out <= y_out + 1'b1;
					end
				end
			else
				x_out <= x_out + 1'b1;	
			end
		else if (enable && !starting)
			if (lose_a_life)
				begin
				life_counter <= life_counter - 1'b1;
				active <= 1'b1;
				end
			if (life_counter == 2'd2 && !currently_erasing && active)
				begin
				write_out <= 1'b1;
				colour_out <= 3'b000;
				x_out <= 8'd146;
				y_out <= 7'd87;
				currently_erasing <= 1'b1;
				end
			if (life_counter == 2'd1 && !currently_erasing && active)
				begin
				write_out <= 1'b1;
				colour_out <= 3'b000;
				x_out <= 8'd146;
				y_out <= 7'd91;
				currently_erasing <= 1'b1;
				end
			if (life_counter == 2'd0 && !currently_erasing && active)
				begin
				write_out <= 1'b1;
				colour_out <= 3'b000;
				x_out <= 8'd146;
				y_out <= 7'd95;
				currently_erasing <= 1'b1;
				end

			if (currently_erasing)
				begin
				if (x_out == 8'd149)
					begin
					if (y_out == 7'd90 || y_out == 7'd94)
						begin
						x_out <= 8'd146;
						y_out <= y_out + 1'b1;
						currently_erasing <= 1'b0;
						write_out <= 1'b0;
						active	<= 1'b0;
						end
					else if (y_out == 7'd98)
						begin
						game_over <= 1'b1;
						write_out <= 1'b0;
						active	<= 1'b0;
						end
					else
						begin
						y_out <= y_out + 1'b1;
						x_out <= 8'd146;
						end
					end
				else
					x_out <= x_out + 1'b1;
				end
				
	end

endmodule
