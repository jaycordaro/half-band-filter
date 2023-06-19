# half-band-filter
An implementation of a half-band filter, from MATLAB to fixed point in SystemVerilog.  

# Half-Band Filters

# Matlab Implementation

## fi, and the problem with fi
## Q Format
For this code, Q.15 consists of a sign bit plus 15 fractional bits = 16 bits.  In this code,

## Q Conversion
### Float to Q
To convert a number from floating point to Qm.n format:

Multiply the floating point number by 2^n -1
Round to the nearest integer
### Q to float
To convert a number from Qm.n format to floating point:

Convert the number to floating point as if it were an integer, in other words remove the binary point
Multiply by 2^−n 
