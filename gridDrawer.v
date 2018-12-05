module gridDrawer(clk, resetn, enable, exit, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable;
	output	reg		exit, write_out;
	output	reg 	[7:0]	x_out;
	output	reg 	[6:0]	y_out;
	output	 	[2:0]	colour_out;
	reg			go_right;

	//draw grid from top-down, then left-right.
	always@(posedge clk) 
	begin
		if(!resetn)
			begin
			x_out <= 8'd23;
			y_out <= 7'd3;
			go_right <= 1'b1;
			write_out <= 1'b1;
			exit <= 1'b0;
			end
		else if(enable && go_right) 
			begin
			if (x_out == 8'd136)
				begin
				x_out <= 8'd23;
				if 	(y_out == 7'd3)
					 y_out <= 7'd40;
				else if (y_out == 7'd40)
					 y_out <= 7'd41;
				else if (y_out == 7'd41)
					 y_out <= 7'd78;
				else if (y_out == 7'd78)
					 y_out <= 7'd79;
				else if (y_out == 7'd79)
					 y_out <= 7'd116;
				else if (y_out == 7'd116)
					begin
					 x_out <= 8'd23;
					 y_out <= 7'd3;
					 go_right <= 1'b0;
					end
				end
			else
				x_out <= x_out + 1'b1;
			end

		else if(enable && !go_right) 
			begin
			if (y_out == 7'd116) 
				begin
				y_out <= 7'd3;
				if 	(x_out == 8'd23)
					 x_out <= 8'd60;
				else if (x_out == 8'd60)
					 x_out <= 8'd61;
				else if (x_out == 8'd61)
					 x_out <= 8'd98;
				else if (x_out == 8'd98)
					 x_out <= 8'd99;
				else if (x_out == 8'd99)
					 x_out <= 8'd136;
				else if (x_out == 8'd136)
					write_out <= 1'b0;
					exit <= 1'b1;
				end
			else
				y_out <= y_out + 1'b1;
			end
	end
	
	always@(posedge enable)
	begin
		x_out <= 8'd23;
		y_out <= 7'd3;
		go_right <= 1'b1;
		write_out <= 1'b1;
		exit <= 1'b0;
	end

	assign colour_out = 3'b111;

endmodule
