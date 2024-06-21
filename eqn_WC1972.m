%%%% Define the function describing the coupled differential equations %%%%

function dy = eqn_WC1972(~,y,wcParams,stimParams)

dy = zeros(2,1);
dy(1) = (-y(1) + (wcParams.ke - wcParams.re*y(1))*Sx((wcParams.c1*y(1) - wcParams.c2*y(2) + stimParams.P),wcParams.ae,wcParams.thetae))./wcParams.taue;
dy(2) = (-y(2) + (wcParams.ki - wcParams.ri*y(2))*Sx((wcParams.c3*y(1) - wcParams.c4*y(2) + stimParams.Q),wcParams.ai,wcParams.thetai))./wcParams.taui;
end

% This is the original sigmoidal function of the WC model (equation 15)
function y = Sx(x,a,theta)
y= 1./(1+exp(-a*(x-theta))) - 1/(1+exp(a*theta));
end