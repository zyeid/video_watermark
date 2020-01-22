`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 04:32:05 PM
// Design Name: 
// Module Name: FSM_RefWin
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


module FSM_RefWin(
	input pclk,
	input [18:0] addr_in,

	output reg wr
);
parameter width = 640;//640
parameter high = 480;//480
parameter w_size = 8;// window size


	reg [1:0] state=2'b00;
	parameter S0=2'b00, S1=2'b01, S2=2'b10;

	reg [18:0] count_s0=0;
	reg [18:0] count_s2;
	reg [18:0] count_s1=0;



always @( posedge pclk ) begin //
	case (state)
		S0: begin //
		 	wr <= 0;
		 	if (addr_in==0)
		 		count_s0=0;
			if (addr_in==count_s0-1+(w_size-1)*width+w_size)
				state <= S1; 				
		end
		S1: begin
			wr <= 1;
			count_s1 <= count_s1 +1;
			if (count_s1==79)	 
				begin     	
	      			state <= S0;
	      			count_s1 <= 0;
	      			count_s0=addr_in+1;
	      		end
	      	else 
	      		begin
	      			state <= S2;
	      			count_s2 = addr_in;

	      		end
		end			
		S2: begin // 
			wr <= 0;
			if (addr_in==count_s2+w_size)
				state <= S1;
			else begin
				state <= S2;
			end
		end

	endcase
end


endmodule
