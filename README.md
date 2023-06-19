# half-band-filter
An implementation of a half-band filter, from MATLAB to fixed point in SystemVerilog.  It annoyed me there was not much fixed point FIR filter code, showing how to take a Matlab model and generate RTL.  

# Half-Band Filters

# Matlab Implementation

## fi, and the problem with fi

In RTL, fixed point filters are implemented in various formats, Q Format is the most common, although I have seen others in industry.  The `fi` function are useful to check for overflow and optimize bit-widths, but the actual filter implementation will be in Q format.  

## Q Format
For this code, Q.15 consists of a sign bit plus 15 fractional bits = 16 bits.  For more information on Q Format, see the Wikipedia page.  

## Q Conversion

For our purposes, Q conversions are as follows:
### Float to Q
To convert a number from floating point to Qm.n format:

Multiply the floating point number by (2^n -1)
Round to the nearest integer

### Q to float
To convert a number from Qm.n format to floating point:

Convert the number to floating point as if it were an integer, in other words remove the binary point
Multiply by (2^−n -1)
