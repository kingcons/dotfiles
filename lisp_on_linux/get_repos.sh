#!/bin/sh
for repo in "coleslaw" \
            "cl-6502" \
            "famiclom" \
            "romreader" \
            "slideware" \
            "trowel"; do
    git clone git@github.com/redline6561/$repo.git;
done
