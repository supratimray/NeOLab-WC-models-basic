% The WC differential equations used in Tsodyks, 1997. First paper on ISN

function dy = eqn_WCTsodyks(~,y,wcParams,stimParams,outParam)

if ~exist('outParam','var');              outParam=0;                   end
dy = zeros(2,1);
dy(1) = (-y(1) + fx(wcParams.Jee*y(1) - wcParams.Jei*y(2) + stimParams.e,wcParams.theta,wcParams.beta))./wcParams.taue;
dy(2) = (-y(2) + fx(wcParams.Jie*y(1) - wcParams.Jii*y(2) + stimParams.i,wcParams.theta,wcParams.beta))./wcParams.taui;

if outParam==1
    dy=dy(1);
elseif outParam==2
    dy=dy(2);
end
end
function f = fx(x,theta,beta)
 f = tanh(x);
% if x<theta
%     f=beta*(x-theta);
% %    f=0;
% elseif x<theta+1/beta
%     f=beta*(x-theta);
% else
%     f=beta*(x-theta);
% %    f=1;
% end
end