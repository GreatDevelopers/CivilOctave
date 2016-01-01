##
# This file run all files needed to process data sagemath.main and get output as # pdf through latex  
# @author amarjeet kapoor
# 
#
cd $1
latex civil.tex
sage civil.sagetex.sage
pdflatex civil.tex
