Assembler.py instructions are found in usage.txt

there is another py file here that generates a textfile, who's name is specified by the argument used to call it;
i.e. python notRandom1.py program1/notRandom.txt generates a notRandom.txt in the program1 folder which is 256 entries that alternate between
01010101 and 00000101 for notRandom1.py, 01011010 and 10101010 for notRandom2.py, and exclusively
00000000 for notRandom3.py, to replicate the example input from the termProject document. The name "notRandom.txt" is what
is currently set to be read into DataMem's "Core" logic array
provided is similar python code called Random.py which does the same thing but with random bytes (syntax is the same
though if you name the file "Random.txt" it won't match what DataMem is set to read).

To run the test benches, you must:
1. use assembler.py to generate the "out.txt" files in each program folder
2. Either use Random.py or notRandom(1/2/3).py to generate the txt file that populates DataMem (*file parsed is currently
set to "notRandom.txt"*)

This is a single-cycle, accumulator processor with a 9 bit instruction width.

program one huffman encodes MEM[0-29] to MEM[30-59].

program two effectively reverses program 1.

program 3 is meant to find the instances of a pattern over a span of memory, counting by instances within individual bytes,
instances within a word (might be split between bytes) and all instances.

Only program one functions properly at the moment.
