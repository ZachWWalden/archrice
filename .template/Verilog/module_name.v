/*==================================================================================
 *Module - <++>
 *Author - Zach Walden
 *Created - DATE
 *Last Changed - DATE
 *Description -
 *Parameters -
====================================================================================*/

module <++>
#(

)
(
	input clock,
	input reset,
);

	always @ (posedge clock)
	begin

	end

// the "macro" to dump signals
`ifdef COCOTB_SIM
initial begin
  $dumpfile ("<++>.vcd");
  $dumpvars (0, <++>);
  #1;
end
`endif
endmodule
