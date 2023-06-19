# Matlab Code

# hb_check and hb_check_tb

`hb_check.m` implements the half-band filter in Q Format.  
`hb_check_tb.m` is a function that generates a chirp from user-defined sampling, starting frequency, and duration, plots the time domain and PSD of the input and output, and saves the input and output in Q15.
The input and output files can be loaded by the SystemVerilog test bench, to compare the SV module with the Matlab code.  
## Usage:

`hb_check_tb(Fs, F0, T)` 
where `Fs`= sampling frequency in Hz, `F0`= starting frequency in Hz, `T` = duration of chirp.

for example `hb_check_tb(32e3,100,1)`

