module scoreManager(clk, resetn, enable, increase_score, score_out);
	input			clk, resetn, enable, increase_score;
	output	reg	[15:0]	score_out;
	
	always@(posedge clk)
	begin
		if(!resetn || !enable) 
			score_out <= 16'd0;
		else if(increase_score)
			score_out <= score_out + 1'd1;
	end

endmodule

module displayScore(score_in, hex_disp_0, hex_disp_1, hex_disp_2, hex_disp_3);
	input	[15:0]	score_in;
	output	[6:0]	hex_disp_0, hex_disp_1, hex_disp_2, hex_disp_3;
	
	sevenSegment ss0(score_in[3:0]  , hex_disp_0);
	sevenSegment ss1(score_in[7:4]  , hex_disp_1);
	sevenSegment ss2(score_in[11:8] , hex_disp_2);
	sevenSegment ss3(score_in[15:12], hex_disp_3);
endmodule

module sevenSegment(num, segment);
	input	[3:0] num;
	output	[6:0] segment;

	// on = 0, off = 1
	assign segment[0] =  ~num[3] & ~num[2] & ~num[1] &  num[0] | //1
			     ~num[3] &  num[2] & ~num[1] & ~num[0] | //4
			      num[3] & ~num[2] &  num[1] &  num[0] | //B
			      num[3] &  num[2] & ~num[1] &  num[0];  //D

	assign segment[1] =  ~num[3] &  num[2] & ~num[1] &  num[0] | //5
			      num[3] &  num[2] &           ~num[0] | //C, E
			      num[3] &            num[1] &  num[0] | //B, F
			      num[2] &  num[1] & ~num[0];            //6, E

	assign segment[2] =  ~num[3] & ~num[2] &  num[1] & ~num[0] | //2
			      num[3] &  num[2] &           ~num[0] | //C, E
			      num[3] &  num[2] &  num[1];            //E, F

	assign segment[3] =  ~num[3] &  num[2] & ~num[1] & ~num[0] | //4
			      num[3] & ~num[2] &  num[1] & ~num[0] | //A
			               ~num[2] & ~num[1] &  num[0] | //1,9
			                num[2] &  num[1] &  num[0];  //7,F

	assign segment[4] =            ~num[2] & ~num[1] &  num[0] | //1,9
			     ~num[3] &  num[2] & ~num[1]           | //4,5
			     ~num[3] &                      num[0];  //1,3,5,7

	assign segment[5] =   num[3] &  num[2] & ~num[1] &  num[0] | //D
			     ~num[3] & ~num[2]           &  num[0] | //1,3
			     ~num[3] & ~num[2] &  num[1]           | //2,3
			     ~num[3] &            num[1] &  num[0];  //3,7

	assign segment[6] =  ~num[3] &  num[2] &  num[1] &  num[0] | //7
			      num[3] &  num[2] & ~num[1] & ~num[0] | //C
			     ~num[3] & ~num[2] & ~num[1];            //1,0
endmodule
