//trigger.v
//logic for selecting logic analyzer trigger
//also allow for configureable polarity
//expect it is driven by any number of 32 bit registers
//support up to 32 inputs

module trigger(
	       input [31:0] triggers_in, //these are the actual possible triggers
	       input [31:0] enable, //any signal enabled is fed into trigger logic
	       input [31:0] polarity, //polarity bit set will invert the trigger
	       input 	    and_n_or, //if set, use a logical AND of inputs, if clear, use a logical OR
	       output trigger_out
	       );

   wire 	      trig_1;
   assign trig_1 = ((triggers_in ^ polarity) & enable);
   
   assign trigger_out = and_n_or ? (&trig_1) : (|trig_1);
     
endmodule

  
