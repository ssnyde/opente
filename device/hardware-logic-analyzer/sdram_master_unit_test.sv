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
   reg 	 clk, reset_n, waitrequest, test_mode, test_start;
   wire [31:0] address;
   wire [31:0] writedata;
   wire        write, test_active;
   
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
     waitrequest = 0;
     test_mode = 0;
     test_start = 0;
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
`SVTEST(test0)
   test_start = 1;
   check_counter = 8'd0;
   @(posedge clk);
   #1;
   test_start = 0;
   repeat (256) begin
      `FAIL_UNLESS_EQUAL(writedata,{~check_counter, check_counter, ~check_counter, check_counter})
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end
   `SVTEST_END


  `SVUNIT_TESTS_END

endmodule
