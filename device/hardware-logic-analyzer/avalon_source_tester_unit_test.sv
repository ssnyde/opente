`include "svunit_defines.svh"
`include "avalon_source_tester.v"

module avalon_source_tester_unit_test;
  import svunit_pkg::svunit_testcase;

  string name = "avalon_source_tester_ut";
  svunit_testcase svunit_ut;


  //===================================
  // This is the UUT that we're 
  // running the Unit Tests on
  //===================================
   parameter SIZE_OF_PATTERN = 2;
   parameter SIZE_OF_COUNTER = 8;

   reg 	 reset_n, clk, st_ready, start;
   reg [SIZE_OF_PATTERN-1:0] pattern;
   wire [31:0] 		     st_data;
   wire 		     st_valid;
   reg [SIZE_OF_COUNTER-1:0] size;

   avalon_source_tester #(SIZE_OF_COUNTER, SIZE_OF_PATTERN) my_avalon_source_tester(.*);

   initial begin
      clk = 0;
      forever #10 clk = !clk;
   end

   reg [SIZE_OF_COUNTER-1:0] check_counter;

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
     st_ready = 1;
     pattern = {SIZE_OF_PATTERN{1'b0}};
     start = 0;
     size = 8'hff;
     
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
    `SVTEST(always_ready_pattern_0)
   check_counter = {SIZE_OF_COUNTER{1'b0}};
   start = 1;
   @(posedge clk);
   #1;
   start = 0;
   repeat (size+1) begin
      `FAIL_UNLESS_EQUAL(st_data, check_counter);
      `FAIL_UNLESS(st_valid);
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end
   `FAIL_UNLESS_EQUAL(st_data, 32'd0);
   `FAIL_IF(st_valid);
   `SVTEST_END

     `SVTEST(always_ready_pattern_1)
   check_counter = {SIZE_OF_COUNTER{1'b0}};
   start = 1;
   pattern = {{(SIZE_OF_PATTERN-1){1'b0}}, 1'b1};
   @(posedge clk);
   #1;
   start = 0;
   repeat (size+1) begin
      `FAIL_UNLESS_EQUAL(st_data, {32{check_counter[0]}});
      `FAIL_UNLESS(st_valid);
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end
   `FAIL_UNLESS_EQUAL(st_data, 32'd0);
   `FAIL_IF(st_valid);
   `SVTEST_END

     `SVTEST(always_ready_pattern_2)
   check_counter = {SIZE_OF_COUNTER{1'b0}};
   start = 1;
   pattern = {{(SIZE_OF_PATTERN-2){1'b0}}, 2'd2};
   @(posedge clk);
   #1;
   start = 0;
   repeat (size+1) begin
      `FAIL_UNLESS_EQUAL(st_data, ((32'd1)<<check_counter[4:0]));
      `FAIL_UNLESS(st_valid);
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end
   `FAIL_UNLESS_EQUAL(st_data, 32'd0);
   `FAIL_IF(st_valid);
   `SVTEST_END

     
`SVTEST(half_ready_pattern_0)
   check_counter = {SIZE_OF_COUNTER{1'b0}};
   start = 1;
   @(posedge clk);
   #1;
   start = 0;
   repeat (size) begin
      st_ready = 0;
      `FAIL_UNLESS_EQUAL(st_data, check_counter);
      `FAIL_UNLESS(st_valid);
      @(posedge clk);
      #1;
      st_ready = 1;
      `FAIL_UNLESS_EQUAL(st_data, check_counter);
      `FAIL_UNLESS(st_valid);
      check_counter = check_counter + 1;
      @(posedge clk);
      #1;
   end 
   `FAIL_UNLESS_EQUAL(st_data, check_counter);
   `FAIL_UNLESS(st_valid);
   @(posedge clk);
   #1;
   `FAIL_UNLESS_EQUAL(st_data, 32'd0);
   `FAIL_IF(st_valid);
   `SVTEST_END
  `SVUNIT_TESTS_END

endmodule
