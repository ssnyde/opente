`include "svunit_defines.svh"
`include "regfile.v"

module regfile_unit_test;
   import svunit_pkg::svunit_testcase;
   
   string name = "regfile_ut";
   svunit_testcase svunit_ut;


   //===================================
   // This is the UUT that we're 
   // running the Unit Tests on
   //===================================
   reg 	  clk, read, write;
   reg [20:0] address;
   reg [31:0] writedata;
   wire [31:0] readdata;
   wire        waitrequest;
   
   regfile my_regfile(.*);

   initial begin
      clk = 0;
      read = 0;
      write = 0;
      address = 20'h0;
      writedata = 32'h0;
      forever #10 clk = !clk;
   end

   


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
   @(posedge clk);
   #1;
   writedata = 32'hdeadbeef;
   write = 1;
   @(posedge clk);
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'hdeadbeef);
   writedata = 32'h0;
   @(posedge clk);
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'h0);
   address = 20'h1;
   writedata = 32'habcd1234;
   @(posedge clk);
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'habcd1234);
   writedata = 32'h0;
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'habcd1234);
   @(posedge clk);
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'h0);
   `SVTEST_END
     
     `SVUNIT_TESTS_END

       endmodule
