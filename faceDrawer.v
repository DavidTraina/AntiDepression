module faceDrawer(clk, resetn, enable, location, colour_in, finished, x_out, y_out, colour_out, write_out);
	input		clk, resetn, enable;
	input	[3:0]	location;
	input	[2:0]	colour_in;
	output	reg	finished;
	output	[7:0]	x_out;
	output	[6:0]	y_out;
	output	[2:0]	colour_out;
	output	reg	write_out;
	reg	[7:0]	next_x;
	reg	[6:0]	next_y;
	reg	[7:0]	start_x;
	reg	[6:0]	start_y;
	


	//loop through every pixel in 36x36.
	always@(posedge clk)
	begin
		if (!resetn)
			begin
			next_x <= 8'd0;
			next_y <= 7'd0;
			write_out <= 1'b1;
			finished <= 1'b0;
			end
		else if (enable)
			begin
			if (next_x == 8'd35)
				begin
				if (next_y == 7'd35)
					begin
					write_out <= 1'b0;
					finished <= 1'b1;
					end
				else
					begin
					next_y <= next_y + 1'd1;
					next_x <= 8'd0;
					end
				end
			else 
				next_x <= next_x + 1'd1;
			end	
	end

	always@(location[3:0])
	begin
		next_x <= 8'd0;
		next_y <= 7'd0;
		write_out <= 1'b1;
		finished <= 1'b0;
	end

	
	//selects the top-most, left-most pixel of the corresponding tile
	always@(location[3:0])
	begin
		case(location[3:0])
			4'd0:	begin
				start_x = 8'd24;
				start_y = 7'd4;
					end
			4'd1:	begin
				start_x = 8'd62;
				start_y = 7'd4;
					end
			4'd2:	begin
				start_x = 8'd100;
				start_y = 7'd4;
					end
			4'd3:	begin
				start_x = 8'd24;
				start_y = 7'd42;
					end
			4'd4:	begin
				start_x = 8'd62;
				start_y = 7'd42;
					end
			4'd5:	begin
				start_x = 8'd100;
				start_y = 7'd42;
					end
			4'd6:	begin
				start_x = 8'd24;
				start_y = 7'd80;
					end
			4'd7:	begin
				start_x = 8'd62;
				start_y = 7'd80;
					end
			4'd8:	begin
				start_x = 8'd100;
				start_y = 7'd80;
					end
			default:begin
				start_x = 8'd4;
				start_y = 7'd24;
					end
		endcase	
	end	
	
	assign x_out = start_x + next_x;
	assign y_out = start_y + next_y;
	assign colour_out = colour_in;

endmodule
