`timescale 1ns / 1ps

module Greedy_Snake(
   input clk,
	input reset,
	input left,
	input right,
	input up,
	input down,
	output h_sync,
	output v_sync,
	output [2:0] RGB
	);


	wire left_key_press, right_key_press, up_key_press, down_key_press;
	wire [1:0] snake;
	wire [9:0] x_pos;
	wire [9:0] y_pos;
	wire [5:0] apple_x;
	wire [4:0] apple_y;
	wire [5:0] head_x;
	wire [5:0] head_y;
	wire inc_len;
	wire [1:0] game_status;
	wire hit_wall;
	wire hit_body;
	wire die_flash;
	wire restart;
	wire [6:0] len;

	Ctrl_unit ctrl_unit(
		.clk(clk),
		.reset(reset),
		.key1_press(left_key_press),
		.key2_press(right_key_press),
		.key3_press(up_key_press),
		.key4_press(down_key_press),
		.game_status(game_status),
		.hit_wall(hit_wall),
		.hit_body(hit_body),
		.die_flash(die_flash),
		.restart(restart)
	);
	
	Snake snake_main(
		.clk(clk),
		.reset(reset),
		.left_press(left_key_press),
		.right_press(right_key_press),
		.up_press(up_key_press),
		.down_press(down_key_press),
		.snake(snake),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.head_x(head_x),
		.head_y(head_y),
		.inc_len(inc_len),
		.game_status(game_status),
		.len(len),
		.hit_body(hit_body),
		.hit_wall(hit_wall),
		.die_flash(die_flash)
		);
	
	Eating_apple eating_apple(
		.clk(clk),
		.reset(reset),
		.apple_x(apple_x),
		.apple_y(apple_y),
		.head_x(head_x),
		.head_y(head_y)
	);

	Key key_ctrl(
		.clk(clk),
		.reset(reset),.left(left),
		.right(right),
		.up(up),
		.down(down),
		.left_key_press(left_key_press), 
		.right_key_press(right_key_press),
		.up_key_press(up_key_press),
		.down_key_press(down_key_press)
	);

	
	VGA_display  vga_display(
		.clk(clk),
		.reset(reset),
		.h_sync(h_sync),
		.v_sync(v_sync), 
		.snake(snake),
		.RGB(RGB),
		.x_pos(x_pos), 
		.y_pos(y_pos),
		.apple_x(apple_x),
		.apple_y(apple_y)
	);

endmodule