# Matlab Code

It would definitely be possbile to write these functions in Python or C++, it's just that I am most familiar with Matlab.  

# hb_check and hb_check_tb

`hb_check.m` implements the half-band filter in Q.15 Format in FIR Type I format.  It uses [persistent](https://www.mathworks.com/help/matlab/ref/persistent.html) variables for the taps, and partial sums.  
`hb_check_tb.m` is a function that generates a chirp waveform from user-defined sampling, starting frequency, and duration.  The function then calls `hb_check.m` repeatedly to do the filtering, and plots the time domain and PSD of the input and output, and saves the input and output in Q.15.  The `inputs.txt` and `outputs.txt` input and output text files can be loaded by the SystemVerilog testbench, to compare the SV module with the Matlab code.  
## Usage:

`hb_check_tb(Fs, F0, T)` 
where `Fs`= sampling frequency in Hz, `F0`= starting frequency in Hz, `T` = duration of chirp.

for example `hb_check_tb(32e3,100,1)`

