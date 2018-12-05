module startscreenDrawer(clk, resetn, enable, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable;
	output	reg	[7:0]	x_out;
	output	reg	[6:0]	y_out;
	output		[2:0]	colour_out;
	output	reg		write_out;


	always@(posedge clk)
	begin
		if (!resetn)
			begin
			x_out <= 8'd0;
			y_out <= 7'd0;
			write_out <= 1'b1;
			end
		else if (enable)
			begin
			if(x_out == 8'd159)
				begin
				if(y_out == 7'd119)
					write_out <= 1'b0;
				else
					begin
					x_out <= 8'd0;
					y_out <= y_out + 1'b1;
					end
				end
			else
				x_out <= x_out + 1'b1;
			end
	end

	always@(posedge enable)
	begin
		x_out <= 8'd0;
		y_out <= 7'd0;
		write_out <= 1'b1;
	end

	assign colour_out = 3'b111;

endmodule


module startscreenEraser(clk, resetn, enable, exit, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable;
	output	reg		exit;
	output	reg	[7:0]	x_out;
	output	reg	[6:0]	y_out;
	output		[2:0]	colour_out;
	output	reg		write_out;


	always@(posedge clk)
	begin
		if (!resetn)
			begin
			x_out <= 8'd0;
			y_out <= 7'd0;
			write_out <= 1'b1;
			exit <= 1'b0;
			end
		else if (enable)
			begin
			if(x_out == 8'd159)
				begin
				if(y_out == 7'd119)
					begin
					write_out <= 1'b0;
					exit <= 1'b1;
					end
				else
					begin
					x_out <= 8'd0;
					y_out <= y_out + 1'b1;
					end
				end
			else
				x_out <= x_out + 1'b1;
			end
	end

	always@(posedge enable)
	begin
		x_out <= 8'd0;
		y_out <= 7'd0;
		write_out <= 1'b1;
		exit <= 1'b0;
	end

	assign colour_out = 3'b000;

endmodule


module endscreenDrawer(clk, resetn, enable, x_out, y_out, colour_out, write_out);
	input			clk, resetn, enable;
	output	reg	[7:0]	x_out;
	output	reg	[6:0]	y_out;
	output		[2:0]	colour_out;
	output	reg		write_out;


	always@(posedge clk)
	begin
		if (!resetn)
			begin
			x_out <= 8'd0;
			y_out <= 7'd52;
			write_out <= 1'b1;
			end
		else if (enable)
			begin
			if(x_out == 8'd159)
				begin
				if(y_out == 7'd67)
					write_out <= 1'b0;
				else
					begin
					x_out <= 8'd0;
					y_out <= y_out + 1'b1;
					end
				end
			else
				x_out <= x_out + 1'b1;
			end
	end

	always@(posedge enable)
	begin
		x_out <= 8'd0;
		y_out <= 7'd52;
		write_out <= 1'b1;
	end

	assign colour_out = 3'b001;

endmodule
