module regfile(
	       input 		 clk,
	       input [20:0] 	 address, //2MB address space
	       input 		 read,
	       output reg [31:0] readdata,
	       input 		 write,
	       input [31:0] 	 writedata,
	       output 		 waitrequest
	       );
   
   
   reg [31:0] 		     regfile[7:0];
   
   always @(*) begin
      if (address < 20'hff)
	readdata = regfile[address[7:0]];
      else if (address == 20'h100)
	readdata = 32'hdeadbeef;
      else
	readdata = 32'd0;
   end

   always @(posedge clk) begin
      if (write && address <= 20'hff)
	regfile[address[7:0]] = writedata;
   end

   assign waitreqeust = 1'b0;
  
endmodule // regfile

	       
