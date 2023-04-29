#!/bin/sh
# Benchmarks current and old version of pwndbg (provided as git commit)
# Usage: bench.sh <old-commit>
rm *.prof *.stats *.results

set -e

# Current code, benchmark 3
gdb --batch --ex 'entry' --ex 'source gdbscript3.py' --args $(which python3) -c 'import sys; sys.exit(0)'
mv profile.prof curr3.prof
python3 ../print_stats.py curr3.prof > curr3.stats
mv results curr3.results

# Current code, benchmark 4
gdb --batch --ex 'entry' --ex 'source gdbscript4.py' --args $(which python3) -c 'import sys; sys.exit(0)'
mv profile.prof curr4.prof
python3 ../print_stats.py curr4.prof > curr4.stats
mv results curr4.results

# Switch to old version
git checkout $1

# Old code, benchmark 3
gdb --batch --ex 'entry' --ex 'source gdbscript3.py' --args $(which python3) -c 'import sys; sys.exit(0)'
mv profile.prof old3.prof
python3 ../print_stats.py old3.prof > old3.stats
mv results old3.results

# Old code, benchmark 4
gdb --batch --ex 'entry' --ex 'source gdbscript4.py' --args $(which python3) -c 'import sys; sys.exit(0)'
mv profile.prof old4.prof
python4 ../print_stats.py old4.prof > old4.stats
mv results old4.results


git checkout -
