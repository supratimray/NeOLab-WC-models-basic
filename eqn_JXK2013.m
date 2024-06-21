% Define the function describing the coupled differential equations. 

function dy = eqn_JXK2013(~,y,wcParams,stimParams)

% The modified WC equations for Jia et al are:
% E' = [-E + Wee*(h(E)*(1-MN)) - Wie*h(I) + Wge*h(G) + I_E(c,MN,theta)]/taue
% I' = [-I + Wei*(h(E)*(1-MN)) - Wii*h(I) + Wgi*h(G) + I_I(c,MN,theta)]/taui
% G' = [-G + Weg*(h(E)*(1-MN)*r^2)]/taug
% where h(x) = x if x>0, h(x) = 0 otherwise
% I_E(c,MN,theta) = Rmax*(c^2/(c^2 + chalf^2))*(1-MN)*(1+(cos(theta))^2)/2
% The value of I_E and I_I define the mean of a Poisson distribution, from which a random variable is drawn on each time step

RmaxE=40; c50E=0.3;
RmaxI=32; c50I=0.3;

dy = zeros(3,1);
dy(1) = (-y(1) + (wcParams.wee*hx(y(1))*(1-stimParams.MN)) - (wcParams.wie*hx(y(2))) + (wcParams.wge*hx(y(3))) + (poissrnd(externalCurrent(stimParams.c,stimParams.MN,stimParams.theta,RmaxE,c50E))))./wcParams.taue;
dy(2) = (-y(2) + (wcParams.wei*hx(y(1))*(1-stimParams.MN)) - (wcParams.wii*hx(y(2))) + (wcParams.wgi*hx(y(3))) + (poissrnd(externalCurrent(stimParams.c,stimParams.MN,stimParams.theta,RmaxI,c50I))))./wcParams.taui;
%dy(1) = (-y(1) + (wcParams.wee*hx(y(1))*(1-stimParams.MN)) - (wcParams.wie*hx(y(2))) + (wcParams.wge*hx(y(3))) + ((externalCurrent(stimParams.c,stimParams.MN,stimParams.theta,RmaxE,c50E))))./wcParams.taue;
%dy(2) = (-y(2) + (wcParams.wei*hx(y(1))*(1-stimParams.MN)) - (wcParams.wii*hx(y(2))) + (wcParams.wgi*hx(y(3))) + ((externalCurrent(stimParams.c,stimParams.MN,stimParams.theta,RmaxI,c50I))))./wcParams.taui;
dy(3) = (-y(3) + (wcParams.weg*hx(y(1))*(1-stimParams.MN)*(stimParams.r^2)))./wcParams.taug;
end

function h = hx(x)
if (x>0)
    h = x;
else
    h = 0;
end
end

function I = externalCurrent(c,MN,theta,Rmax,c50)
I = Rmax * (c^2/(c^2+c50^2)) * (1-MN) * (1+cos(theta)^2)/2;
end