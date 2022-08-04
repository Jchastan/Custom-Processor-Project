
module Control(
    input               TypeBit,
    input        [3:0]  OP,
    output logic        RWrite,
    output logic        AWrite,
    output logic        Halt,
    output logic        Branch,
    output logic        ReadMem,
    output logic        WriteMem,
    output logic        LookUp,
    output logic        reset,
    output logic        isMem

    );
    always_comb	begin
            case(OP)
                0 : begin       //get $reg: $accumulator = $reg
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;

                end
                1 : begin       //set $reg: $reg = $accumulator
                    RWrite    = 1;
                    AWrite    = 0;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                2 : begin       //lw $reg: $accumulator = MEM[$reg]
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 1;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 1;
                end
                3 : begin       //sw $reg: MEM[$reg] = $accumulator
                    RWrite    = 0;
                    AWrite    = 0;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 1;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                4 : begin      //add $reg: $accumulator = $accumulator + $reg
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                5 : begin      //sub $reg: $accumulator = $accumulator - $reg
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                6 : begin      //reset: set overflow bit register to zero 
                    RWrite    = 0;
                    AWrite    = 0;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 1;
                    isMem       = 0;
                end
                7 : begin       //bt : $accumulator = table [key]
                    RWrite    = 0;
                    AWrite    = 0;
                    Halt        = 0;
                    Branch      = 1;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 1;
                    reset       = 0;
                    isMem       = 0;
                end
                8 : begin       //bf : $accumulator = table [key]
                    RWrite    = 0;
                    AWrite    = 0;
                    Halt        = 0;
                    Branch      = 1;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 1;
                    reset       = 0;
                    isMem       = 0;
                end
                9 : begin      //eq $reg: if $accumulator == $reg, $accumulator = 1, else $accumulator = 0
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                10 : begin       //lt $reg: if $accumulator < $reg, $accumulator = 1, else accumulator = 0
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                11 : begin       //xor $reg: $accumulator = $accumulator ^ $reg
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                12 : begin       //parse : $accumulator = table [key]
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                13 : begin       //shl $reg: accumulator = $accumulator << $reg
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end            
                14 : begin       //shr $reg: $accumulator = $accumulator >> $reg
                    RWrite    = 0;
                    AWrite    = 1;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                15 : begin      //halt: PC <= PC
                    RWrite    = 0;
                    AWrite    = 0;
                    Halt        = 1;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
                default : begin //tba
                    RWrite    = 0;
                    AWrite    = 0;
                    Halt        = 0;
                    Branch      = 0;
                    ReadMem     = 0;
                    WriteMem    = 0;
                    LookUp      = 0;
                    reset       = 0;
                    isMem       = 0;
                end
            endcase
        if(TypeBit==1'b0) begin	//geti $reg = $accumulator = #immediate
            RWrite    = 0;
            AWrite    = 1;
            Halt        = 0;
            Branch      = 0;
            ReadMem     = 0;
            WriteMem    = 0;
            LookUp      = 0;
            reset       = 0;
            isMem       = 0;
        end // end else
    end // end always_comb logic

endmodule
