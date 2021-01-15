//sdram_master.v
//this module is the avalon mm master to the hps sdram

module sdram_master(
		    input 	  reset_n,
		    input 	  clk,
		    //avalon-mm interface, write only
		    //based on Cyclon V HPS TRM
		    //omitting bureset_ncount and byteenable for now
		    output [31:0] mm_address,
		    output 	  mm_write,
		    output [31:0] mm_writedata,
		    input 	  mm_waitrequest,
		    //avalon-st interface, sink
		    input [31:0]  st_data,
		    input 	  st_valid,
		    output 	  st_ready,
		    //control signals
		    input [31:0]  new_address,
		    input 	  set_address,
		    output [31:0] current_address,
		    //test mode control signals
		    input 	  test_mode,
		    input 	  test_start,
		    output 	  test_active
		    );

   //*** NORMAL MODE ***
   //param definitions
   //word address on reset
   parameter BASE_ADDRESS = 32'h0c000000;
   //allows for 256MB buffer
   parameter MAX_ADDRESS = 32'h10000000;
   //flop definitions
   reg [31:0] 				  address;
   //wire definitions
   wire 				  write;
   wire [31:0] 				  address_next;
   wire [31:0] 				  new_address_limited;

   //continuous assignments
   assign st_ready = !mm_waitrequest;
   assign write = st_valid;
   assign new_address_limited = ((new_address < BASE_ADDRESS) || (new_address > MAX_ADDRESS)) ? BASE_ADDRESS : new_address;
   assign address_next = set_address ? new_address_limited :
			    (address >= MAX_ADDRESS) ? address : 
			    (st_valid && !mm_waitrequest) ? (address + 1) : address;

   //flip flops / registers
   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
	 address = BASE_ADDRESS;
      end else begin
	 address = address_next;
      end
   end // always @ (posedge clk or negedge reset_n)

   //*** TEST MODE ***
   //param definitions
   localparam TEST_STATE_IDLE = 0;
   localparam TEST_STATE_INC_WRITE = 1;
   //flop definitions
   reg [7:0] 				  test_counter;
   reg 					  test_start_q;
   reg 					  test_start_edge_q;
   reg [1:0] 				  test_state;
   //procedural assignment definitions
   reg [7:0] 				  test_next_counter;
   reg [1:0] 				  test_next_state;
   reg 					  test_write;
   reg [31:0] test_writedata;
   reg [31:0] test_address;
   //wire definitions
   wire 				  test_start_edge;
   
   //continuous assignments
   assign test_start_edge = test_start && !test_start_q;
   //test_active stays high until test_start clears, so you have a chance to read it to confirm, then clear it by deasserting test_start
   assign test_active = test_start_edge_q;
   
   //test mode flip flops / registers
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
      test_write = 0;
      test_writedata = 32'd0;
      test_address = BASE_ADDRESS;
      case (test_state)
	TEST_STATE_IDLE: begin
	   if (test_start_edge) begin
	      test_next_state = TEST_STATE_INC_WRITE;
	   end
	end
	TEST_STATE_INC_WRITE: begin
	   test_write = 1;
	   test_writedata = {~test_counter, test_counter, ~test_counter, test_counter};
	   test_address = BASE_ADDRESS + test_counter;
	   if (!mm_waitrequest)
	     test_next_counter = test_counter + 8'd1;
	   if (!mm_waitrequest && (test_counter == 8'hff)) begin
	      test_next_state = TEST_STATE_IDLE;
	      test_next_counter = 0;
	   end
	end
      endcase
   end // always @ (*)

   //*** Normal / Test mode selection ***
   assign mm_address = test_mode ? test_address : address;
   assign mm_write = test_mode ? test_write : write;
   assign mm_writedata = test_mode ? test_writedata : st_data;
   assign current_address = mm_address;
   
endmodule
