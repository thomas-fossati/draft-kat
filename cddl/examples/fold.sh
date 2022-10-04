#!/bin/bash

set -eux

for f in *.diag
do
	fold -w 68 $f > $f.tmp
	mv $f.tmp $f
done
