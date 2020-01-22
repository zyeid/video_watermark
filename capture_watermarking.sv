`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2019 07:28:13 AM
// Design Name: 
// Module Name: capture_watermarking
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


module capture_watermarking(
 	input pclk,
    input vsync,
    input href,
    input [7:0] d,

	output [7:0] wked_pixel,
	output wked_pixel_ready,
	output  [18:0]wked_pixel_adrr//initialize 0

);

wire [18:0] addr;
wire [15:0] dout;
wire we;


pixel_capture capture_mod(
           .pclk(pclk),
           .vsync(vsync),
           .href(href),
           .d(d),
           .addr(addr),
           .dout(dout),
           .we(we)
);

watermarking_module module_wk(
	.pclk(pclk),
	.data_in(dout),
	.en_in(we),
	.addr_in(addr),

	.wked_pixel(wked_pixel),
	.wked_pixel_ready(wked_pixel_ready),
	.wked_pixel_adrr(wked_pixel_adrr)
);


endmodule
