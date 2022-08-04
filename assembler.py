# assembler
# rule:
# 1. label should be followed by an \n instead of instruction
import sys
#from bitstring import Bits

opcode = {
    'get': 0,
    'set': 1,
    'lw': 2,
    'sw': 3,
    'add': 4,
    'sub': 5,
    'and': 6,
    'bt': 7,
    'bf': 8,
    'eq': 9,
    'lt': 10,
    'xor': 11,
    'parse': 12,
    'lsl': 13,
    'lsr': 14,
    'halt': 15
}

registers = {
    'r0': 0,
    'r1': 1,
    'r2': 2,
    'r3': 3,
    'r4': 4,
    'r5': 5,
    'r6': 6,
    'r7': 7,
    'r8': 8,
    'r9': 9,
    'r10': 10,
    'r11': 11,
    'r12': 12,
    'r13': 13,
    'r14': 14,
    'r15': 15
}



labels = {}



if __name__ == "__main__":
    # extract file name from command line argument
    args = sys.argv
    if len(args) != 3:
        print("you didn't do that right, correct syntax: \n\tpython assembler.py <assembly file> <machine_code file>")
        sys.exit(0);

    print("Avengers... Assemble")

    out = open(args[2], 'w')
    with open(args[1], 'r') as inFile: #, open(args[2], 'w') as out:

        lineCount = 0
        instr = ''
        labelCount = 0 
        label = ''
            # go deal with branch addresses first, this kinda involves adding the instructions to go set them in machine code lol
        for line in inFile:

            line = line.split('#', 1)[0]       # get the non-comment part

            instr = line
            
            words = instr.split()

            # get each lable's address, geti the address to the accumulator, then store that value in the index of the lookup table specified by the labelcounter
            if ':' in line:
                print("Parsing line %d" % lineCount)
                if labelCount > 15:
                    print("too many branches, not good lol")
                labelCount += 1
                continue

        lineCount = 0;

    with open(args[1], 'r') as inFile: #, open(args[2], 'w') as out:

        lineCount = 0
        instr = ''
        labelInd = 0 
        label = ''
            # go deal with branch addresses first, this kinda involves adding the instructions to go set them in machine code lol
        for line in inFile:

            line = line.split('#', 1)[0]       # get the non-comment part

            instr = line
            
            words = instr.split()

            # get each lable's address, geti the address to the accumulator, then store that value in the index of the lookup table specified by the labelcounter
            if ':' in line:
                print("Parsing line %d" % lineCount)
                if labelCount > 15:
                    print("too many branches, not good lol")
                label = line.split(':', 1)[0].strip()
                labels[label] = labelInd
                out.write(format(0, 'b').zfill(1))
                #out.write('_)
                out.write(format(lineCount + 2*(labelCount), 'b').zfill(8))
                out.write('\n')
                out.write(format(1, 'b').zfill(1))
                #out.write('_)
                out.write(format(opcode['parse'], 'b').zfill(4))
                #out.write('_)
                out.write(format(labelInd, 'b').zfill(4))
                out.write('    // ')
                for word in words:
                    out.write(word + ' ')
                out.write('\n')
                labelInd += 1
                lineCount += 1
                continue
            else: 
                lineCount += 1

        lineCount = 0;

    with open(args[1], 'r') as inFile:

        lineCount = 0
        instr = ''

        for line in inFile:

            instr = line
            
            words = instr.split()

            if opcode.has_key(words[0]):
                op = opcode[words[0]]


            print("Assembling line %d" % lineCount)
            line = line.split('#', 1)[0]       # get the non-comment part

            instr = line
            
            words = instr.split()

            if opcode.has_key(words[0]):
                op = opcode[words[0]]

            # put dummy branch
            if ':' in line:
                out.write(format(1, 'b').zfill(1))
                #out.write('_)
                out.write(format(opcode['and'], 'b').zfill(4))
                #out.write('_)
                out.write(format(0, 'b').zfill(4))
                out.write('    // ')
                for word in words:
                    out.write(word + ' ')
                out.write('\n')
                continue

            # syntax check start
            if len(words) == 0:
                pass
            elif len(words) == 1:       # reset or halt 

                out.write(format(1, 'b').zfill(1))
                #out.write('_)
                out.write(format(op, 'b').zfill(4))
                #out.write('_)
                out.write(format(0, 'b').zfill(4))
                out.write('    // ')
                for word in words:
                    out.write(word + ' ')
                out.write('\n')

            elif len(words) == 2:

                if words[0] == 'geti':
                    immediate = int(words[1])
                    out.write(format(0, 'b').zfill(1))
                    #out.write('_)
                    out.write(format(immediate, 'b').zfill(8))
                    out.write('    // ')
                    for word in words:
                        out.write(word + ' ')
                    out.write('\n')

                elif words[0] == 'bt' or words[0] == 'bf':        # if this is a branch instruction
                    if words[1] not in labels:         # check if label exists
                        print("Label not exist at line %d" % lineCount)
                        exit(0)
                    else:                                   
                        index = labels[words[1]]
                        out.write(format(1, 'b').zfill(1))
                        #out.write('_)
                        out.write(format(op, 'b').zfill(4))
                        #out.write('_)
                        out.write(format(index, 'b').zfill(4))
                        out.write('    // ')
                        for word in words:
                            out.write(word + ' ')
                        out.write('\n')

                else:                       # this is a normal instruction excluding lookup
                    reg = registers[words[1]]
                    out.write(format(1, 'b').zfill(1))
                    #out.write('_)
                    out.write(format(op, 'b').zfill(4))
                    #out.write('_)
                    out.write(format(reg, 'b').zfill(4))
                    out.write('    // ')
                    for word in words:
                        out.write(word + ' ')
                    out.write('\n')
            else:
                print("fuck up at line %d" % lineCount)
                exit(0)

            lineCount += 1 # probably does nothing, kept it for print statements

    print("\nAssembler successfully terminated")

