# half-band-filter
An implementation of a half-band filter, from MATLAB to fixed point in SystemVerilog.  It annoyed me there was not much fixed point FIR filter code, showing how to take a Matlab model and generate RTL. 

## Contents

* `readme.md` you're reading this
* ./matlab/ - Directory containing Matlab functions to design the half-band filter, check the implementation in fixed point, and create test vectors for RTL vector matching
* ./rtl/ - Directory containing SystemVerilog RTL code consisting of a synthesizable module and a test bench using the test vectors created with Matlab.
* ./images/ - images for this repo

## Half-Band Filters

<img src="./images/half_band_filter_taps.png">

We can see that this odd-length Symmetric FIR filter every even tap except for the middle tap has a value of 0, and the taps have symmetry about the center tap.  This allows the filter to be implemented in an efficient manner:

<img src="./images/hbfilter.png">
only 8 multiplies are required to implement this 27-tap filter.

### Matlab Implementation

### fi, and the problem with fi

In RTL, fixed point filters are implemented in various formats, Q Format is the most common, although I have seen others in industry.  The Matlab `fi` functions are useful to check for overflow and optimize bit-widths, but the actual filter implementation is typically in Q format.  Fortunately, converting from the Matlab floating point to Q format is very straightforward.

### Q Format and Q Conversion to/from float:
For this code, Q.15 is used and consists of a sign bit plus 15 fractional bits = 16 bits.  For more information on Q Format, see the Wikipedia page.  

For our purposes, Q conversions are as follows:
#### Float to Q
To convert a number from floating point to Qm.n format:

Multiply the floating point number by (2^n -1)
Round to the nearest integer

#### Q to float
To convert a number from Qm.n format to floating point:

Convert the number to floating point as if it were an integer, remove the binary point
Multiply by (2^−n -1)
