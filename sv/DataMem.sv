
module DataMem(
  input              CLK,
  input [7:0]        DataAddress,
  input              ReadMem,
  input              WriteMem,
  input [7:0]        DataIn,
  output logic[7:0]  DataOut);

  logic [7:0] Core [256];

  initial 
    $readmemb("notRandom.txt", Core);

  always_comb
    if(ReadMem) begin
        DataOut = Core[DataAddress];
        //$display("Memory read M[%d] = %d",DataAddress,DataOut);
    end 
    else 
      DataOut = 8'bZ;

  always_ff @ (posedge CLK)
    if(WriteMem) begin
        Core[DataAddress] = DataIn;
        //$display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
