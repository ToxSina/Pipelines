#!/usr/bin/env python

import argparse
import pysam

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


def print_passed(name, outname):
    vcf = pysam.VariantFile(name)
    vcf_out = pysam.VariantFile(outname, 'w', header=vcf.header)
    records = vcf.fetch()
    for r in records:
        for f in r.filter:
            if f == "PASS":
                vcf_out.write(r)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("infile", help="Input vcf.gz file",
                        type=str)
    parser.add_argument("outfile", help="Output vcf file",
                        type=str)
    args = parser.parse_args()
    print_passed(args.infile, args.outfile)
