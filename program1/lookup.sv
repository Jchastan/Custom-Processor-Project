module lookup (
  input  [3:0]  key,
  input	 [7:0] storeAddr,
  input Clk,
  input write,
  output logic [7:0] value
  );

logic [7:0] registers[16];

//change the value later for program usage
always_comb begin
    if (write) begin
	registers[key] <= storeAddr;
	value <= 0;
    end
    else
	value <= registers[key];

end
endmodule
