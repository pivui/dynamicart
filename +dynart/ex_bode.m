function ex_bode(H)
w = logspace(-2,2,200);
h = freqresp(H,w);
dynart.bode(h,w);
end