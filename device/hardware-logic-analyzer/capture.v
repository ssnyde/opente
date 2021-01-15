//capture.v
//logic for capturing digital signals at a particular rate

module capture(
	       input 		 reset_n,
	       input 		 clk,
	       //avalon-st interface, source
	       output reg [31:0] st_data,
	       output reg 	 st_valid,
	       input 		 st_ready,
	       //logic analyzer inputs
	       input [31:0] 	 logic_inputs,
	       //control signals
	       input 		 start_capture,
	       input [31:0] 	 capture_size,
	       input [7:0] 	 capture_clock_divider,
	       );

   
   
endmodule

  
