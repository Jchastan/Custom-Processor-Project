import sys
if __name__ == "__main__":
    # extract file name from command line argument
    args = sys.argv
    if len(args) != 2:
        print("you didn't do that right, correct syntax: \n\tpython random.py <output file>")
        sys.exit(0)
    out = open(args[1], 'w')

    for i in range(128):
        out.write(format(85,'b').zfill(8))
        out.write('\n')
        out.write(format(5,'b').zfill(8))
        out.write('\n')

