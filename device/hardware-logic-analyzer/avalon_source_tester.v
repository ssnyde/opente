//sdram_master.v
//this module is the avalon mm master to the hps sdram

module avalon_source_tester
  #(
    //256MB buffer is 64Mword, 26 bits to address
    parameter SIZE_OF_COUNTER = 26,
    parameter SIZE_OF_PATTERN = 2
    )
  (
			    input 			reset_n,
			    input 			clk,
			    //avalon-st interface, source
			    output reg [31:0] 		st_data,
			    output reg 			st_valid,
			    input 			st_ready,
			    //control signals
			    input [SIZE_OF_PATTERN-1:0] pattern,
			    input 			start,
			    input [SIZE_OF_COUNTER-1:0] size
			    );

   //param definitions
   localparam SIZE_OF_STATE_REG = 1;
   localparam STATE_IDLE = 1'd0;
   localparam STATE_RUNNING = 1'd1;
   
   //flop definitions
   reg [SIZE_OF_COUNTER-1:0] 		  counter;
   reg [SIZE_OF_STATE_REG-1:0] 		  state;

   //procedural assignment definitions
   reg [SIZE_OF_COUNTER-1:0] 		  next_counter;
   reg [SIZE_OF_STATE_REG-1:0] 		  next_state;

   //wire definitions
   

   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
	 counter <= {SIZE_OF_COUNTER{1'b0}};
	 state <= STATE_IDLE;
      end else begin
	 counter <= next_counter;
	 state <= next_state;
      end
   end
   
   always @(*) begin
      next_state = state;
      next_counter = counter;
      st_data = 32'd0;
      st_valid = 1'b0;
      case (state)
	STATE_IDLE: begin
	   if (start) begin
	      next_state = STATE_RUNNING;
	   end
	end
	STATE_RUNNING: begin
	   st_valid = 1'b1;
	   if (counter < size) begin
	      if (st_ready)  //else do not increment, default condition
		next_counter <= counter + {{(SIZE_OF_COUNTER-1){1'b0}}, 1'b1};
	   end else begin
	      next_state = STATE_IDLE;
	      next_counter <= {SIZE_OF_COUNTER{1'b0}};
	   end
	   case (pattern)
	     //pattern = 0, count up from 0 by 1
	     {SIZE_OF_PATTERN{1'b0}}: begin
		st_data = counter;
	     end
	     //pattern = 1, alternate words of 0 and 0xffffffff
	     {{(SIZE_OF_PATTERN-1){1'b0}}, 1'd1}: begin
		st_data = {32{counter[0]}};
	     end
	     //pattern = 2, 
	     {{(SIZE_OF_PATTERN-2){1'b0}}, 2'd2}: begin
		st_data = ((32'd1)<<counter[4:0]); 
	     end
	   endcase
	end
      endcase
   end
endmodule
