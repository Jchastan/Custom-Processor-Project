module IF(
  input Branch,
  input [7:0] Target,
  input start,
  input Halt,
  input CLK,
  output logic[8:0] instruction
  );

logic[7:0] PC;
logic[8:0] instructionMemory1 [256];
logic[8:0] instructionMemory2 [256];
logic[8:0] instructionMemory3 [256];

int fd1;
int fd2;
int fd3;
int fd4;
int programSelector;
int tmp;
int counter;

    initial begin
	programSelector = 1;
	$readmemb("out1.txt",instructionMemory1,0,255); 
	$readmemb("out2.txt",instructionMemory2,0,255); 
	$readmemb("out3.txt",instructionMemory3,0,255); 
    end


//todo: set up reading in instructions
    always@(posedge Halt)
	programSelector <= programSelector + 1;

    always_ff@(posedge CLK)
    begin
	    if(start)
	        PC <= 0;              //can change to start_address
	    else if(Halt)
	        PC <= PC;
	    else if(Branch)
	        PC <= Target;    //jump directly to addresses
	    else
	        PC <= PC+8'b00_0000_0001;
    end
    always_comb begin
	case(programSelector)
	    1 : begin
		instruction = instructionMemory1[PC];
	    end
	    2 : begin
		instruction = instructionMemory2[PC];
	    end
	    3 : begin
		instruction = instructionMemory3[PC];
	    end
	endcase
    end
endmodule
