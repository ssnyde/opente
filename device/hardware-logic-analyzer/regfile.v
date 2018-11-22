//regfile.v
//registers with avalon mm slave interface
//64 registers total
//lower 32 read only registers, 32-bits, broken out into one port per register
//upper 32 read/write registers, 32-bits, broken out into one port per register

module regfile(
	       input 		 clk,
	       input 		 reset_n,
	       //6bit space, 64 registers, 32 writeable, 32 read only
	       input [5:0] 	 address, 
	       input 		 read,
	       output reg [31:0] readdata,
	       input 		 write,
	       input [31:0] 	 writedata,
	       output 		 waitrequest,
	       //registers broken out as individual ports
	       output [31:0] 	 reg_0,
	       output [31:0] 	 reg_1,
	       output [31:0] 	 reg_2,
	       output [31:0] 	 reg_3,
	       output [31:0] 	 reg_4,
	       output [31:0] 	 reg_5,
	       output [31:0] 	 reg_6,
	       output [31:0] 	 reg_7,
	       output [31:0] 	 reg_8,
	       output [31:0] 	 reg_9,
	       output [31:0] 	 reg_10,
	       output [31:0] 	 reg_11,
	       output [31:0] 	 reg_12,
	       output [31:0] 	 reg_13,
	       output [31:0] 	 reg_14,
	       output [31:0] 	 reg_15,
	       output [31:0] 	 reg_16,
	       output [31:0] 	 reg_17,
	       output [31:0] 	 reg_18,
	       output [31:0] 	 reg_19,
	       output [31:0] 	 reg_20,
	       output [31:0] 	 reg_21,
	       output [31:0] 	 reg_22,
	       output [31:0] 	 reg_23,
	       output [31:0] 	 reg_24,
	       output [31:0] 	 reg_25,
	       output [31:0] 	 reg_26,
	       output [31:0] 	 reg_27,
	       output [31:0] 	 reg_28,
	       output [31:0] 	 reg_29,
	       output [31:0] 	 reg_30,
	       output [31:0] 	 reg_31,
	       input [31:0] 	 reg_32,
	       input [31:0] 	 reg_33,
	       input [31:0] 	 reg_34,
	       input [31:0] 	 reg_35,
	       input [31:0] 	 reg_36,
	       input [31:0] 	 reg_37,
	       input [31:0] 	 reg_38,
	       input [31:0] 	 reg_39,
	       input [31:0] 	 reg_40,
	       input [31:0] 	 reg_41,
	       input [31:0] 	 reg_42,
	       input [31:0] 	 reg_43,
	       input [31:0] 	 reg_44,
	       input [31:0] 	 reg_45,
	       input [31:0] 	 reg_46,
	       input [31:0] 	 reg_47,
	       input [31:0] 	 reg_48,
	       input [31:0] 	 reg_49,
	       input [31:0] 	 reg_50,
	       input [31:0] 	 reg_51,
	       input [31:0] 	 reg_52,
	       input [31:0] 	 reg_53,
	       input [31:0] 	 reg_54,
	       input [31:0] 	 reg_55,
	       input [31:0] 	 reg_56,
	       input [31:0] 	 reg_57,
	       input [31:0] 	 reg_58,
	       input [31:0] 	 reg_59,
	       input [31:0] 	 reg_60,
	       input [31:0] 	 reg_61,
	       input [31:0] 	 reg_62,
	       input [31:0] 	 reg_63
	       );
   
   
   reg [31:0] 			 regfile[31:0];

   //decoder logic, first 32 registers read from regfile, next from wires
   always @(*) begin
      if (read) begin
	 if (address < 6'd32)
	   readdata = regfile[address[4:0]];
	 else if (address == 6'd32)
	   readdata = reg_32;
	 else if (address == 6'd33)
	   readdata = reg_33;
	 else if (address == 6'd34)
	   readdata = reg_34;
	 else if (address == 6'd35)
	   readdata = reg_35;
	 else if (address == 6'd36)
	   readdata = reg_36;
	 else if (address == 6'd37)
	   readdata = reg_37;
	 else if (address == 6'd38)
	   readdata = reg_38;
	 else if (address == 6'd39)
	   readdata = reg_39;
	 else if (address == 6'd40)
	   readdata = reg_40;
	 else if (address == 6'd41)
	   readdata = reg_41;
	 else if (address == 6'd42)
	   readdata = reg_42;
	 else if (address == 6'd43)
	   readdata = reg_43;
	 else if (address == 6'd44)
	   readdata = reg_44;
	 else if (address == 6'd45)
	   readdata = reg_45;
	 else if (address == 6'd46)
	   readdata = reg_46;
	 else if (address == 6'd47)
	   readdata = reg_47;
	 else if (address == 6'd48)
	   readdata = reg_48;
	 else if (address == 6'd49)
	   readdata = reg_49;
	 else if (address == 6'd50)
	   readdata = reg_50;
	 else if (address == 6'd51)
	   readdata = reg_51;
	 else if (address == 6'd52)
	   readdata = reg_52;
	 else if (address == 6'd53)
	   readdata = reg_53;
	 else if (address == 6'd54)
	   readdata = reg_54;
	 else if (address == 6'd55)
	   readdata = reg_55;
	 else if (address == 6'd56)
	   readdata = reg_56;
	 else if (address == 6'd57)
	   readdata = reg_57;
	 else if (address == 6'd58)
	   readdata = reg_58;
	 else if (address == 6'd59)
	   readdata = reg_59;
	 else if (address == 6'd60)
	   readdata = reg_60;
	 else if (address == 6'd61)
	   readdata = reg_61;
	 else if (address == 6'd62)
	   readdata = reg_62;
	 else if (address == 6'd63)
	   readdata = reg_63;
	 else
	   readdata = 32'd0;
      end else begin // if (read)
	 readdata = 32'd0;
      end
   end // always @ (*)

   assign reg_0 = regfile[0];
   assign reg_1 = regfile[1];
   assign reg_2 = regfile[2];
   assign reg_3 = regfile[3];
   assign reg_4 = regfile[4];
   assign reg_5 = regfile[5];
   assign reg_6 = regfile[6];
   assign reg_7 = regfile[7];
   assign reg_8 = regfile[8];
   assign reg_9 = regfile[9];
   assign reg_10 = regfile[10];
   assign reg_11 = regfile[11];
   assign reg_12 = regfile[12];
   assign reg_13 = regfile[13];
   assign reg_14 = regfile[14];
   assign reg_15 = regfile[15];
   assign reg_16 = regfile[16];
   assign reg_17 = regfile[17];
   assign reg_18 = regfile[18];
   assign reg_19 = regfile[19];
   assign reg_20 = regfile[20];
   assign reg_21 = regfile[21];
   assign reg_22 = regfile[22];
   assign reg_23 = regfile[23];
   assign reg_24 = regfile[24];
   assign reg_25 = regfile[25];
   assign reg_26 = regfile[26];
   assign reg_27 = regfile[27];
   assign reg_28 = regfile[28];
   assign reg_29 = regfile[29];
   assign reg_30 = regfile[30];
   assign reg_31 = regfile[31];

   //reset and write
   genvar j;
   generate
      for (j=0; j<32; j=j+1) begin: genwrites
	 always @(posedge clk or negedge reset_n) begin
	    if (!reset_n) begin
	       regfile[j] <= 32'd0;
	    end else begin
	       regfile[j] <= (write && (address[4:0] == j)) ? writedata : regfile[j];
	    end
	 end
      end
   endgenerate

   assign waitrequest = 1'b0;
  
endmodule // regfile

	       
