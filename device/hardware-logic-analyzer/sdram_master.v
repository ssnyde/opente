//sdram_master.v
//this module is the avalon mm master to the hps sdram

module sdram_master(
		    input 	      reset_n,
		    input 	      clk,
		    //avalon-mm interface, write only
		    //based on Cyclon V HPS TRM
		    //omitting bureset_ncount and byteenable for now
		    output reg [31:0] address,
		    output reg 	      write,
		    output reg [31:0] writedata,
		    input 	      waitrequest,
		    //test pattern signals
		    input 	      test_mode,
		    input 	      test_start,
		    output 	      test_active
		    );

   reg [1:0] 			  test_state;
   reg [1:0] 			  test_next_state;
   
   localparam TEST_STATE_IDLE = 0;
   localparam TEST_STATE_INC_WRITE = 1;
   //word address
   localparam BASE_ADDRESS = 32'h0c000000;

   reg [7:0] 				  test_counter;
   reg [7:0] 				  test_next_counter;

   reg 					  test_start_q;
   wire 				  test_start_edge;
   reg 					  test_start_edge_q;

   //continuous assignments
   assign test_start_edge = test_start && !test_start_q;
   //assign test_active = ((test_state != TEST_STATE_IDLE) && !test_start_edge);
   assign test_active = test_start_edge_q;

   //flip flops / registers
   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
	 test_state <= TEST_STATE_IDLE;
	 test_counter <= 8'd0;
	 test_start_q <= 0;
	 test_start_edge_q <= 0;
      end
      else begin
	 test_state <= test_next_state;
	 test_counter <= test_next_counter;
	 test_start_q <= test_start;
	 test_start_edge_q <= (test_start_edge_q | test_start_edge) & test_start;
      end
   end // always @ (posedge clk or negedge reset_n)

   //state machine state transitions and outputs
   always @(*) begin
      test_next_state = test_state;
      test_next_counter = test_counter;
      write = 0;
      writedata = 32'd0;
      address = BASE_ADDRESS;
      case (test_state)
	TEST_STATE_IDLE: begin
	   if (test_start_edge) begin
	      test_next_state = TEST_STATE_INC_WRITE;
	   end
	end
	TEST_STATE_INC_WRITE: begin
	   write = 1;
	   writedata = {~test_counter, test_counter, ~test_counter, test_counter};
	   address = BASE_ADDRESS + test_counter;
	   if (!waitrequest)
	     test_next_counter = test_counter + 8'd1;
	   if (!waitrequest && (test_counter == 8'hff))
	     test_next_state = TEST_STATE_IDLE;
	end
      endcase
   end
endmodule
