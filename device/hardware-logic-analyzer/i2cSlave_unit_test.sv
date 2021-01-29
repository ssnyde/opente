`include "svunit_defines.svh"
`include "serialInterface.v"
`include "registerInterface.v"
`include "i2cSlave.v"

module i2cSlave_unit_test;
  import svunit_pkg::svunit_testcase;

  string name = "i2cSlave_ut";
  svunit_testcase svunit_ut;


  //===================================
  // This is the UUT that we're 
  // running the Unit Tests on
  //===================================
   reg 	 clk, rst, sda_out, sda_out_en, scl;
   wire [7:0] Configuration_L;
   wire [7:0] Configuration_H;
   reg 	      Configuration_HIGH_Alert;
   reg 	      Configuration_LOW_Alert;
   reg 	      Configuration_Data_Ready;
   reg 	      Configuration_EEPROM_Busy;
   reg [7:0]  Temp_Result_L;
   reg [7:0]  Temp_Result_H;
   tri1       sda;
   wire      sda_in;
   wire [7:0] i2cRead_last_addr;
   wire       i2cRead_complete;

   //for use in testbench
   reg [15:0] check_read;
   
   assign sda_in = sda;
   assign sda = sda_out_en ? sda_out : 1'bz;
   
  i2cSlave my_i2cSlave(.*);

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
     scl = 1;
     sda_out_en = 1;
     sda_out = 1;

     Configuration_HIGH_Alert = 0;
     Configuration_LOW_Alert = 0;
     Configuration_Data_Ready = 0;
     Configuration_EEPROM_Busy = 0;
     
     
     @(posedge clk);
     #1;
     rst = 1;
     @(posedge clk);
     @(posedge clk);
     #1;
     rst = 0;
     #2500;
  endtask


  //===================================
  // Here we deconstruct anything we 
  // need after running the Unit Tests
  //===================================
  task teardown();
    svunit_ut.teardown();
    /* Place Teardown Code Here */

  endtask

   task write_reg;
      input [6:0] i2c_addr;
      input [7:0] reg_addr;
      input [15:0] reg_data;
      integer 	  i;

      //start bit
      sda_out_en = 1;
      sda_out = 0;
      #2500;
      scl = 0;
      
      for (i = 6; i >= 0; i = i - 1) begin
	 #625;
	 sda_out = i2c_addr[i];
	 #625;
	 scl = 1;
	 #1250;
	 scl = 0;
      end
      //write bit
      #625;
      sda_out = 0;
      #625
      scl = 1;
      #1250;
      scl = 0;
      //ack
      #625;
      sda_out_en = 0;
      #625;
      scl = 1;
      #625;
      `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
      #625;
      scl = 0;
      for (i = 7; i >= 0; i = i - 1) begin
	 #625;
	 sda_out_en = 1;
	 sda_out = reg_addr[i];
	 #625;
	 scl = 1;
	 #1250;
	 scl = 0;
      end
      //ack
      #625;
      sda_out_en = 0;
      #625;
      scl = 1;
      #625;
      `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
      #625;
      scl = 0;
      for (i = 15; i >= 8; i = i - 1) begin
	 #625;
	 sda_out_en = 1;
	 sda_out = reg_data[i];
	 #625;
	 scl = 1;
	 #1250;
	 scl = 0;
      end
      //ack
      #625;
      sda_out_en = 0;
      #625;
      scl = 1;
      #625;
      `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
      #625;
      scl = 0;
      for (i = 7; i >= 0; i = i - 1) begin
	 #625;
	 sda_out_en = 1;
	 sda_out = reg_data[i];
	 #625;
	 scl = 1;
	 #1250;
	 scl = 0;
      end
      //ack
      #625;
      sda_out_en = 0;
      #625;
      scl = 1;
      #625;
      `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
      #625;      
      scl = 0;
      //stop bit
      #625;
      sda_out_en = 1;
      sda_out = 0;
      #625;
      scl = 1;
      #625;
      sda_out = 1;
      #2500;
   endtask // for

   task read_reg;
      input [6:0] i2c_addr;
      input [7:0] reg_addr;
      output [15:0] reg_data;
      integer 	  i, j;
      reg 	  got_i2cRead_complete;
      reg [7:0]   check_i2cRead_last_addr;

      reg_data = 16'h0;
      got_i2cRead_complete = 0;
      check_i2cRead_last_addr = 8'hx;

      fork : f
	 begin
	    //start bit
	    sda_out_en = 1;
	    sda_out = 0;
	    #2500;
	    scl = 0;
	    //i2c address
	    for (i = 6; i >= 0; i = i - 1) begin
	       #625;
	       sda_out = i2c_addr[i];
	       #625;
	       scl = 1;
	       #1250;
	       scl = 0;
	    end
	    //write bit
	    #625;
	    sda_out = 0;
	    #625
	      scl = 1;
	    #1250;
	    scl = 0;
	    //ack
	    #625;
	    sda_out_en = 0;
	    #625;
	    scl = 1;
	    #625;
	    `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
	    #625;
	    scl = 0;
	    //register address
	    for (i = 7; i >= 0; i = i - 1) begin
	       #625;
	       sda_out_en = 1;
	       sda_out = reg_addr[i];
	       #625;
	       scl = 1;
	       #1250;
	       scl = 0;
	    end
	    //ack
	    #625;
	    sda_out_en = 0;
	    #625;
	    scl = 1;
	    #625;
	    `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
	    #625;
	    scl = 0;
	    //stop bit
	    #625;
	    sda_out_en = 1;
	    sda_out = 0;
	    #625;
	    scl = 1;
	    #625;
	    sda_out = 1;
	    #2500;
	    
	    //start bit
	    sda_out_en = 1;
	    sda_out = 0;
	    #2500;
	    scl = 0;
	    //i2c address
	    for (i = 6; i >= 0; i = i - 1) begin
	       #625;
	       sda_out = i2c_addr[i];
	       #625;
	       scl = 1;
	       #1250;
	       scl = 0;
	    end
	    //read bit
	    #625;
	    sda_out = 1;
	    #625
	      scl = 1;
	    #1250;
	    scl = 0;
	    //ack
	    #625;
	    sda_out_en = 0;
	    #625;
	    scl = 1;
	    #625;
	    `FAIL_UNLESS_EQUAL(sda_in, 1'b0);
	    #625;
	    scl = 0;
	    #625;
	    for (j = 0; j < 2; j = j + 1) begin
	       //read bytes
	       for (i = 0; i < 8; i = i + 1) begin
		  #625;
		  scl = 1;
		  #625;
		  reg_data = (reg_data << 1) | sda_in;
		  #625;
		  scl = 0;
		  #625;
	       end
	       sda_out_en = 1;
	       sda_out = (j == 1) ? 1 : 0;
	       #625;
	       scl = 1;
	       #1250;
	       scl = 0;
	       #625;
	       sda_out_en = (j == 1) ? 1 : 0;
	    end // for (j = 0; j < 2; j = j + 1)
	    //stop bit
	    #625;
	    sda_out_en = 1;
	    sda_out = 0;
	    #625;
	    scl = 1;
	    #625;
	    sda_out = 1;      
	    #2500;
	    disable f;
	 end // fork
	 begin
	    @(posedge i2cRead_complete);
	    got_i2cRead_complete = 1'b1;
	    #1;
	    check_i2cRead_last_addr = i2cRead_last_addr;
	 end
      join
      `FAIL_UNLESS(got_i2cRead_complete);
      `FAIL_UNLESS_EQUAL(check_i2cRead_last_addr, reg_addr);
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
   #2500;
   //Configuration 
   write_reg(7'h44, 8'h1, 16'hdead);
   `FAIL_UNLESS_EQUAL(Configuration_H, 8'hde);
   `FAIL_UNLESS_EQUAL(Configuration_L, 8'had);
   `SVTEST_END
     
     `SVTEST(test1)
   Temp_Result_H = 8'hab;
   Temp_Result_L = 8'h78;
   read_reg(7'h44, 8'h0, check_read);
   $display("Temp_Result = %x", check_read);
   `FAIL_UNLESS_EQUAL(check_read, 16'hab78);
   #2500;
   `SVTEST_END

     `SVTEST(test2)
   #2500;
   //Configuration 
   write_reg(7'h44, 8'h1, 16'hdead);
   `FAIL_UNLESS_EQUAL(Configuration_H, 8'hde);
   `FAIL_UNLESS_EQUAL(Configuration_L, 8'had);
   read_reg(7'h44, 8'h1, check_read);
   `FAIL_UNLESS_EQUAL(check_read, 16'h0eac);
   `SVTEST_END
     
  `SVUNIT_TESTS_END

endmodule
