module IF(
  input Branch,
  input [7:0] Target,
  input Start,
  input Halt,
  input Clk,
  output logic[8:0] instruction
  );

logic[7:0] ProgCtr;
logic[8:0] instructionMemory [256];

    initial
	$readmemb("out.txt",instructionMemory,0,255); 


    always_ff@(posedge Clk)
    begin
	    if(Start)
	        ProgCtr <= 0;              //can change to Start_address
	    else if(Halt)
	        ProgCtr <= ProgCtr;
	    else if(Branch)
	        ProgCtr <= Target;    //jump directly to addresses
	    else
	        ProgCtr <= ProgCtr+8'b00_0000_0001;
    end
    always_comb begin
	instruction = instructionMemory[ProgCtr];
    end
endmodule
