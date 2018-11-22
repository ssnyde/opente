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
   reg [5:0] address;
   reg [31:0] writedata;
   wire [31:0] readdata;
   wire        waitrequest;
   reg 	       reset_n;
   
   regfile my_regfile(.clk(clk),
		      .read(read),
		      .write(write),
		      .address(address),
		      .writedata(writedata),
		      .readdata(readdata),
		      .waitrequest(waitrequest),
		      .reset_n(reset_n),
		      .reg_32(32'hdeadbeef)
		      );

   initial begin
      clk = 0;
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
      reset_n = 1;
      read = 0;
      write = 0;
      address = 6'h0;
      writedata = 32'h0;
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
   
   `SVTEST(zero_after_reset)
   integer j;
   for (j=0; j<32; j=j+1) begin
      address = j;
      #1;
      `FAIL_UNLESS_EQUAL(readdata,32'h0);
   end
   `SVTEST_END

   `SVTEST(write_addr_0_read_back)
   address = 6'h0;
   writedata = 32'hdeadbeef;
   write = 1;
   @(posedge clk);
   #1;
   read = 1;
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'hdeadbeef);
   `SVTEST_END

   `SVTEST(write_addr_1_read_back)
   address = 6'h1;
   writedata = 32'habcd1234;
   write = 1;
   @(posedge clk);
   #1;
   read = 1;
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'habcd1234);
   `SVTEST_END

   `SVTEST(write_preserved_after_changed_writedata)
   address = 6'h1;
   writedata = 32'habcd1234;
   write = 1;
   @(posedge clk);
   #1;
   write = 0;
   writedata = 32'h1234abcd;
   @(posedge clk);
   #1;
   read = 1;
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'habcd1234);
   `SVTEST_END

   `SVTEST(write_pattern_read_back)
   integer j;
   write = 1;
   for (j=0; j<32; j=j+1) begin
      address = j;
      writedata = j;
      @(posedge clk);
      #1;
   end
   write = 0;
   read = 1;
   for (j=0; j<32; j=j+1) begin
      address = j;
      #1;
      `FAIL_UNLESS_EQUAL(readdata,j);
   end
   `SVTEST_END

   `SVTEST(wire_read)
   address = 6'd32;
   read = 1;
   #1;
   `FAIL_UNLESS_EQUAL(readdata,32'hdeadbeef);
   `SVTEST_END
   
   `SVUNIT_TESTS_END

       endmodule
