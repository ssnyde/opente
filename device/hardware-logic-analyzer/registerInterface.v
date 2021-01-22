//////////////////////////////////////////////////////////////////////
////                                                              ////
//// registerInterface.v                                          ////
////                                                              ////
//// This file is part of the i2cSlave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// You will need to modify this file to implement your 
//// interface.
//// Add your control and status bytes/bits to module inputs and outputs,
//// and also to the I2C read and write process blocks  
////                                                              ////
//// To Do:                                                       ////
//// 
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
`include "i2cSlave_define.v"


module registerInterface (
			  clk,
			  addr,
			  dataIn,
			  writeEn,
			  dataOut,
			  Temp_Result_L,
			  Temp_Result_H,
			  Configuration_L,
			  Configuration_H,
			  Configuration_HIGH_Alert,
			  Configuration_LOW_Alert,
			  Configuration_Data_Ready,
			  Configuration_EEPROM_Busy
			  );

`define CHIP_ID_H 8'h01
`define CHIP_ID_L 8'h17
   
   input clk;
   input [7:0] addr;
   input [7:0] dataIn;
   input       writeEn;
   output [7:0] dataOut;
   
   input [7:0] 	Temp_Result_L;
   input [7:0] 	Temp_Result_H;
   output [7:0] Configuration_L;
   output [7:0] Configuration_H;
   input 	Configuration_HIGH_Alert;
   input 	Configuration_LOW_Alert;
   input 	Configuration_Data_Ready;
   input 	Configuration_EEPROM_Busy;

   //combinational register
   reg [7:0] 	dataOut;
   
   //register file
   reg [7:0] 	Configuration_L;
   reg [7:0] 	Configuration_H;
   
   // --- I2C Read
   always @(posedge clk) begin
      case (addr)
	8'h00: dataOut <= Temp_Result_H;  
	8'h01: dataOut <= Temp_Result_L;
	8'h02: dataOut <= {Configuration_HIGH_Alert, Configuration_LOW_Alert, Configuration_Data_Ready, Configuration_EEPROM_Busy, Configuration_H[3:0]};
	8'h03: dataOut <= {Configuration_L[7:1], 1'b0};
	8'h1e: dataOut <= `CHIP_ID_H;
	8'h1f: dataOut <= `CHIP_ID_L;
	default: dataOut <= 8'h00;
      endcase
   end
   
   // --- I2C Write
   always @(posedge clk) begin
      if (writeEn == 1'b1) begin
	 case (addr)
	   8'h02: Configuration_H <= dataIn;
	   8'h03: Configuration_L <= dataIn;
	 endcase
      end
   end
   
endmodule



