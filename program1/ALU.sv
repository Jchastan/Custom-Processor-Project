module ALU(
  input [8:0] immediate,
  input [ 3:0] OP,
  input [7:0] A_in,
  input [7:0] R_in,
  input overflow_in,
  output logic [7:0] OUT,
  output logic overflow_out,
  output logic Branch
    );
	 
wire [7:0] sub;
assign sub = A_in - R_in;

always_comb 
begin
    Branch = 0;
    OUT = 8'b0000_0000;
    overflow_out = overflow_in;

    case(OP)
        //get
        4'b00_00:
            OUT = R_in;
        //set
        4'b00_01:
            OUT = A_in;
        //lw
        4'b00_10:
            OUT = R_in;
        //sw
        4'b00_11:
            OUT = R_in;
        //add
        4'b01_00:
            {overflow_out ,OUT} = A_in + R_in + overflow_in;
        //sub
        4'b01_01:
            OUT = A_in - R_in;
        //and
        4'b01_10:
            OUT = A_in & R_in;
        //bt
        4'b01_11:
	begin
	    if (A_in == 1) begin
		Branch = 1;
		OUT = R_in;
	    end
        end
        //bf
        4'b10_00:
	begin
	    if (A_in == 0) begin
		Branch = 1;
		OUT = R_in;
	    end
        end
        //eq
        4'b10_01:
        begin
            if(sub==8'b0000_0000)
                OUT = 8'b0000_0001;
            else
                OUT = 8'b0000_0000;
        end
        //lt
        4'b10_10:
        begin
            if(sub[7:7]==1'b1)  //negative
                OUT = 8'b0000_0001;
            else
                OUT = 8'b0000_0000;
        end
        //xor
        4'b10_11:
            OUT = A_in ^ R_in;

        //parse
        4'b11_00:
            OUT = A_in;
        //lsl
        4'b11_01:
            OUT = A_in << R_in;
        //lsr
        4'b11_10:
            OUT = A_in >> R_in;
        //halt
        4'b11_11:;
        default:;
    endcase
    if (~immediate[8:8])
	OUT = immediate[7:0];

end //end of always_comb

endmodule
