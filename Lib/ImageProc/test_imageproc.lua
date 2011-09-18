require('ImageProc');
require('carray'); //color array?

cdt = carray.new('c', 262144);
pcdt = carray.pointer(cdt); //pointer of cdt - but what's cdt?

width = 320; //this is half-VGA resolution
height = 240;

rgb = carray.new('c', 3*width*height); //red green blue
prgb = carray.pointer(rgb); //pointer of rgb

/*
Below looks like YUV colorspace, alternative to RGB.
From RGB to YUV
Y = 0.299R + 0.587G + 0.114B
U = 0.492 (B-Y)
V = 0.877 (R-Y)
It can also be represented as:
Y =  0.299R + 0.587G + 0.114B
U = -0.147R - 0.289G + 0.436B
V =  0.615R - 0.515G - 0.100B
From YUV to RGB
R = Y + 1.140V
G = Y - 0.395U - 0.581V
B = Y + 2.032U
from http://www.pcmag.com/encyclopedia_term/0,2542,t=YUVRGB+conversion+formulas&i=55166,00.asp
*/

pyuyv = ImageProc.rgb_to_yuyv(prgb, width*height);
yuyv = carray.cast(pyuyv, 'i', width*height);

plabel = ImageProc.yuyv_to_label(pyuyv, pcdt, width*height);
label = carray.cast(plabel, 'c', width*height);
