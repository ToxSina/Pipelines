#!/usr/bin/env python

import argparse
import re

"""Default.py: This is just my default python script base
that I am too lazy to type out every time I write a new script.
It prints Hello World!"""
"""Import necessary packages and functions"""

__author__ = "Sina Beier"
__copyright__ = "Copyright 2021, MRC Toxicology Unit, Cambridge University"
__credits__ = ["Sina Beier"]
__license__ = "GPL"
__version__ = "GPLv3"
__maintainer__ = "Sina Beier"
__email__ = "sb2534@cam.ac.uk"
__status__ = "Testing"

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("infile", help="Input File", type=str)
    parser.add_argument("outfile", help="Output File", type=str)
    args = parser.parse_args()

    with open(args.infile) as infile:
        with open(args.outfile, "w") as outfile:
            for line in infile:
                if re.match(">", line):
                    # line looks like >NODE_1_length_543924_cov_26.751109
                    l = re.sub("\n", "", line)
                    s = re.split("_cov_", l)
                    newline = s[0] + " weight=" + s[1] + "\n"
                    outfile.write(newline)
                else:
                    outfile.write(line)
