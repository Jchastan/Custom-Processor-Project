module reg_file #(parameter W=8, D=4)(
    input           Clk,
	            RWrite,
                    AWrite,
    input  [ D-1:0] reg_index,
    input  [ W-1:0] writeValue,

    output [ W-1:0] A_out,
    output logic [W-1:0] R_out
    );

// 8 bits wide [7:0] and 16 registers deep [0:15] or just [16]	 
logic [W-1:0] registers[2**D];

initial begin
    for(int i = 0; i < 16; i++)
	registers[i] = 0;
end

// combinational reads
assign A_out = registers[0];              //accumulator is the first register in RF in our design by default
assign R_out = registers[reg_index];

// sequential (clocked) writes
always_ff@(posedge Clk)
begin
    if(AWrite==1'b1)
        registers[0] <= writeValue;
    else
    begin
        if(RWrite==1'b1)
            registers[reg_index] <= writeValue;
    end
end
endmodule
