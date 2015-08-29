# CivilOctave
Use of Octave (MatLAB) in Civil Engineering Problems

To run this program, you need to install `GNU octave` on your computer.
To know how to obtain it, visit: https://www.gnu.org/software/octave/

Once you have GNU Octave working, go to folder where code for an example is
present. For example to run code correspond to example L01, go to folder
Example/L01, ( for example on GNU/Linux you may do so by: `cd Example/L01` ).
The code is in file `main.m`, and data is in file `input.mat`. To store results
in file `output.txt`, type command:

`octave main.m > output.txt`

or in following form, if we wish to produce pdf using LaTeX from folder
(TeX, if available) using run.sh

`octave main.m > output.tex`

View file output.txt in any text editor, or main.pdf (in TeX folder) in pdf
viewer.
