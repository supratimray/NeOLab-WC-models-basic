t=0:1/1000:0.1;
f=50;
g=cos(2*pi*f*t +pi/4); pg=angle(hilbert(g));
h=cos(2*pi*2*f*t)/4; ph=angle(hilbert(h));

plot(t,g,'b'); hold on; plot(t,h,'r'); plot(t,g+h,'k');