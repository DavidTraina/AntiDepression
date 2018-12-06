module random(
  input clk,
  input resetn,

  output reg [4:0] rand_num
);

reg [4:0] next_rand_num;

always @(*)
begin
  next_rand_num[4] = rand_num[4]^rand_num[1];
  next_rand_num[3] = rand_num[3]^rand_num[0];
  next_rand_num[2] = rand_num[2]^next_rand_num[4];
  next_rand_num[1] = rand_num[1]^next_rand_num[3];
  next_rand_num[0] = rand_num[0]^next_rand_num[2];
end

always @(posedge clk or negedge resetn)
  if(!resetn)
    rand_num <= 5'h1f;
  else
    rand_num <= next_rand_num;

endmodule
