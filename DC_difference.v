`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 04:51:17 PM
// Design Name: 
// Module Name: DC_difference
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DC_difference(
	input pclk,
	input o_Q3,
	input [11:0] DC1,
	input [13:0] dS6,
	input o_DC5,

	output reg o_pd1,
	output reg signed [12:0] diff0
);


wire [13:0] DC_delayed;
DC_shift_ram_0 DC_Delay_unit( //ram based shift register: width=14, depth=1, CE=checked
  				.D(dS6),        
  				.CLK(pclk),         
  				.CE(o_DC5),			 
  				.Q(DC_delayed)
);

always@(posedge pclk) begin
	if(o_Q3==1) 
		begin
			diff0 <=  $signed({1'b0, DC1}) - $signed({1'b0, DC_delayed[13:3]});//;
			o_pd1 <= 1;
		end
	else 
		o_pd1 <= 0;
end

endmodule
