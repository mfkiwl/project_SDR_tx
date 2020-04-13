//-----------------------------------------------------------------------------
//
// Title       : upr1
// Design      : list1
// Author      : imk
// Company     : nasa
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\Z1\list1\src\upr1.v
// Generated   : Mon Oct 15 15:11:05 2018
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps 


//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {upr1}}
module upr1 (
	output wire [15:0] adr_rom,	 
	output wire [31:0] data_out,
	output wire tst,
	input wire clk,		
	input wire rst,
	input wire btn,
	input wire [7:0] uart_in,
	input wire uart_rcv,
	input wire [15:0] rom_in
);

parameter  max_adr=12586;

reg [7:0] data_rom=0;
reg [7:0] data_uart=0;
reg [15:0] reg_adr_rom=0;
reg [31:0] accum=0;	

reg [31:0] data_reg=0;

reg [2:0] front1=0;
reg [3:0] front2=0;

reg speed=0;
reg [31:0] sampl_speed=31'd477901;

always @(posedge clk) front2<={front2[2:0],btn};
always @(posedge clk) front1<={front1[1:0],accum[31]};

always @(posedge clk)
	if (rst)
		reg_adr_rom<=0;
	else
		begin
			
			if (front2[3:1]==3'b110) speed<=speed+1;
			if (speed) sampl_speed<=31'd477901; else sampl_speed<=0;
			
			accum<=accum+sampl_speed;
			
			data_reg<=rom_in*11;
			
			if (front1==3'b001)  
				begin
					if (reg_adr_rom<max_adr) reg_adr_rom<=reg_adr_rom+1; else reg_adr_rom<=0;	
				end				
		end
		
	 	assign tst=accum[31]; 
		assign data_out=data_reg; 
		assign adr_rom=reg_adr_rom; 
		
endmodule
