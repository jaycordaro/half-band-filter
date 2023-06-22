function [output]=hb_check(x_in)
% Jay Cordaro, 2023 
% jcordaro@protonmail.com

persistent taps;

persistent w0  w2  w4  w6  w8  w10  w12  w13;
persistent p0 p1 p2 p3 p4 p5 p6;

persistent sum;

if (isempty(taps))
    taps = zeros(1,27); % a 27-tap FIR filter
    w0 =    460;
    w2 =   -483;
    w4 =   750;
    w6 =  -1153;
    w8 =   1835;
    w10 = -3322;
    w12 = 10378;
    w13 = 16384;
    p0 = 0; p1 = 0; p2 = 0; p3 = 0; p4 = 0; p5 = 0; p6=0; % partial sums
    sum=0;
end

taps(1:end-1) = taps(2:end);
taps(end) = x_in;

% compute the products of symmetric coefficients and register values
p0 =  w0 * (taps(1)  + taps(27));
p1 =  w2 * (taps(3)  + taps(25));
p2 =  w4 * (taps(5)  + taps(23));
p3 =  w6 * (taps(7)  + taps(21));
p4 =  w8 * (taps(9)  + taps(19));
p5 = w10 * (taps(11) + taps(17));
p6 = w12 * (taps(13) + taps(15));

% compute the dot product of coefficients and register values
sum = p0 + p1 + p2 + p3 + p4 + p5 + p6 + w13 * taps(14);

% assign output
y_out = sum;

output=y_out./2^15;
end