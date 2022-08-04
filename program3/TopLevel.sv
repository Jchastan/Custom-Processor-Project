
module TopLevel(
    input     Reset,
    input     Start,
    input     Clk,
    output    Ack
    );

    wire[8:0] Instruction;  // our 9-bit opcode
    wire[7:0] PC;  // our 9-bit opcode

    wire RWrite;
    wire AWrite;
    //wire Start;
    //wire Ack;
    wire Branch;
    wire ReadMem;
    wire WriteMem;
    wire LookUp;
    wire reset;
    wire isMem;

    wire [3:0] reg_index;
    wire [7:0] writeValue;
    wire [7:0] A_out;
    wire [7:0] R_out;
 
    wire [7:0] ALU_out;
    wire [7:0] lookup_value;
    wire [7:0] MemOut;

    logic       overflow, overflow_n;    //1 bit overflow register
    logic[31:0] cycle_ct;

    IF PC1(
        .Start,
        .Clk,
        .Halt(Ack),
        .Branch,
        .Target(ALU_out),
        //below is output
        .instruction(Instruction)
    );

	
    Control ctrl(
        .TypeBit(Instruction[8:8]),
        .OP(Instruction[7:4]),
        //below is output
        .RWrite,
        .AWrite,
        .Halt(Ack),
        .ReadMem,
        .WriteMem,
        .LookUp,
        .reset,
        .isMem
        
    );
    
    reg_file RF1(
        .Clk,
        .RWrite,
        .AWrite,
        .reg_index(Instruction[3:0]),
        .writeValue((isMem? MemOut: ALU_out)),
        //below is output
        .A_out,
        .R_out
    );

    ALU alu(
	.immediate(Instruction),
        .OP(Instruction[7:4]),
        .A_in(A_out),
        .R_in((LookUp? lookup_value: R_out)),   //check if the second input of ALU is from table or RF
        .overflow_in(overflow),
        //bellow is output
        .OUT(ALU_out),
        .overflow_out(overflow_n),       //overflow_n is the next overflow value in next clock cycle
	.Branch
    );

    lookup lk(
        .key(Instruction[3:0]),
	.storeAddr(ALU_out),
	.Clk,
	.write((Instruction[7:4] == 4'b1100) && (Instruction[8:8] ==1'b1)),
        .value(lookup_value)
    );

    DataMem DM1(
        .Clk,
        .DataAddress(ALU_out),
        .ReadMem,
        .WriteMem,
        .DataIn(A_out),
        //below is output
        .DataOut(MemOut)
    );

    //set up 1 bit overflow register
    always@(posedge Clk)
        if(Start == 1 || reset ==1)
            overflow <= 1'b0;
        else
            overflow <= overflow_n;


    // count number of instructions executed
    always@(posedge Clk) 
        if (Start == 1)
            cycle_ct <= 0;
        else if(Ack == 0)
            cycle_ct <= cycle_ct+1;
    

endmodule
