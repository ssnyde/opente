module regfile(
	       input 		 clk,
	       input 		 reset_n,
	       //6bit space, 64 registers, 32 writeable, 32 read only
	       input [5:0] 	 address, 
	       input 		 read,
	       output reg [31:0] readdata,
	       input 		 write,
	       input [31:0] 	 writedata,
	       output 		 waitrequest
	       );
   
   
   reg [31:0] 		     regfile[31:0];

   //decoder logic, first 32 registers read from regfile, next from wires
   always @(*) begin
      if (address < 6'd32)
	readdata = regfile[address[4:0]];
      else if (address == 6'd32)
	readdata = 32'hdeadbeef;
      else
	readdata = 32'd0;
   end

   //reset and write
   integer 		     j;
   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
	 for (j=0; j<32; j=j+1) begin
	    regfile[j] <= 32'd0;
	 end
      end else begin
	 if (write && address <= 6'd32)
	   regfile[address[4:0]] = writedata;
      end
   end

   assign waitrequest = 1'b0;
  
endmodule // regfile

	       
