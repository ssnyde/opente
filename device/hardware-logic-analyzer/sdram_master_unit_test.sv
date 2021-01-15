`include "svunit_defines.svh"
`include "sdram_master.v"

module sdram_master_unit_test;
  import svunit_pkg::svunit_testcase;

  string name = "sdram_master_ut";
  svunit_testcase svunit_ut;


  //===================================
  // This is the UUT that we're 
  // running the Unit Tests on
  //===================================
   reg 	 clk, reset_n, mm_waitrequest, test_mode, test_start, st_valid, set_address;
   reg [31:0] new_address;
   reg [31:0] st_data;
   
   wire [31:0] mm_address;
   wire [31:0] mm_writedata;
   wire [31:0] current_address;
   wire        mm_write, test_active, st_ready;

   localparam BASE_ADDRESS = 32'h0c000000;
   
  sdram_master my_sdram_master(.*);

   initial begin
      clk = 0;
      forever #10 clk = !clk;
   end

   reg [7:0] check_counter;

  //===================================
  // Build
  //===================================
  function void build();
    svunit_ut = new(name);
  endfunction


  //===================================
  // Setup for running the Unit Tests
  //===================================
  task setup();
    svunit_ut.setup();
    /* Place Setup Code Here */
     mm_waitrequest = 0;
     set_address = 0;
     new_address = 0;
     test_mode = 0;
     test_start = 0;
     st_valid = 0;
     st_data = 0;
     @(posedge clk);
      #1;
      reset_n = 0;
      @(posedge clk);
      #1;
      reset_n = 1;
  endtask


  //===================================
  // Here we deconstruct anything we 
  // need after running the Unit Tests
  //===================================
  task teardown();
    svunit_ut.teardown();
    /* Place Teardown Code Here */

  endtask


  //===================================
  // All tests are defined between the
  // SVUNIT_TESTS_BEGIN/END macros
  //
  // Each individual test must be
  // defined between `SVTEST(_NAME_)
  // `SVTEST_END
  //
  // i.e.
  //   `SVTEST(mytest)
  //     <test code>
  //   `SVTEST_END
  //===================================
  `SVUNIT_TESTS_BEGIN
`SVTEST(test_mode_0_no_wait)
   test_start = 1;
   test_mode = 1;
   check_counter = 8'd0;
   @(posedge clk);
   #1;
   test_start = 0;
   repeat (256) begin
      `FAIL_UNLESS_EQUAL(mm_writedata,{~check_counter, check_counter, ~check_counter, check_counter})
      `FAIL_UNLESS_EQUAL(mm_address, (BASE_ADDRESS + check_counter));
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end
   `SVTEST_END
     
     `SVTEST(test_mode_0_one_wait)
   test_start = 1;
   test_mode = 1;
   check_counter = 8'd0;
   @(posedge clk);
   #1;
   test_start = 0;
   repeat (256) begin
      `FAIL_UNLESS_EQUAL(mm_writedata,{~check_counter, check_counter, ~check_counter, check_counter})
      `FAIL_UNLESS_EQUAL(mm_address, (BASE_ADDRESS + check_counter));
      mm_waitrequest = 1;
      @(posedge clk);
      #1;
      `FAIL_UNLESS_EQUAL(mm_writedata,{~check_counter, check_counter, ~check_counter, check_counter})
      `FAIL_UNLESS_EQUAL(mm_address, (BASE_ADDRESS + check_counter));
      mm_waitrequest= 0;
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end
   `SVTEST_END

          `SVTEST(test_mode_0_test_active)
   test_start = 1;
   test_mode = 1;
   check_counter = 8'd0;
   @(posedge clk);
   #1;
   //should be set one clock after test_start
   `FAIL_UNLESS(test_active)
   repeat (256) begin
      @(posedge clk);
      #1;
      //should stay set until test_start is deasserted
      `FAIL_UNLESS(test_active);
   end
   test_start = 0;
   @(posedge clk);
   #1;
   //should clear after test_start is deasserted
   `FAIL_IF(test_active);
   `SVTEST_END
     
     `SVTEST(normal_mode_0)
   st_valid = 1;
   st_data = 32'hdeadbeef;
   #1;
   `FAIL_UNLESS(mm_write);
   `FAIL_UNLESS(st_ready)
   `FAIL_UNLESS_EQUAL(mm_writedata, st_data);
   `FAIL_UNLESS_EQUAL(mm_address, BASE_ADDRESS);
   @(posedge clk);
   #1;
   st_data = 32'hbeefdead;
   #1;
   `FAIL_UNLESS(mm_write);
   `FAIL_UNLESS(st_ready);
   `FAIL_UNLESS_EQUAL(mm_writedata, st_data);
   `FAIL_UNLESS_EQUAL(mm_address, BASE_ADDRESS + 1);
   `SVTEST_END

     `SVTEST(normal_mode_waitrequest_0)
   st_valid = 1;
   st_data = 32'hdeadbeef;
   mm_waitrequest = 1;
   #1;
   `FAIL_UNLESS(mm_write);
   `FAIL_IF(st_ready);
   `FAIL_UNLESS_EQUAL(mm_writedata, st_data);
   `FAIL_UNLESS_EQUAL(mm_address, BASE_ADDRESS);
   @(posedge clk);
   #1;
   st_data = 32'hdeadbeef;
   mm_waitrequest = 0;
   #1;
   `FAIL_UNLESS(mm_write);
   `FAIL_UNLESS(st_ready);
   `FAIL_UNLESS_EQUAL(mm_writedata, st_data);
   `FAIL_UNLESS_EQUAL(mm_address, BASE_ADDRESS);
   `SVTEST_END
`SVTEST(normal_mode_set_address)
   set_address = 1;
   new_address = 32'h0c000000;
   #1;
   @(posedge clk);
   `FAIL_UNLESS_EQUAL(current_address, 32'h0c000000);
   `FAIL_UNLESS_EQUAL(mm_address, 32'h0c000000);
   `SVTEST_END
  `SVUNIT_TESTS_END

endmodule
