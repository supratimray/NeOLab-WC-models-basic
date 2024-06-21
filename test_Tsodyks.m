function test_Tsodyks(e0)

eqnName = 'eqn_WCTsodyks';
[wcParams,stimParams] = defaultParams_Tsodyks; % Get default parameters

stimParams.e = e0;
xRange = [-2 2];
yRange = [-2 2];
numDivisions = 20;
xList = linspace(xRange(1),xRange(2),numDivisions+1);
yList = linspace(yRange(1),yRange(2),numDivisions+1);

describeDynamics(eqnName,xList,yList,wcParams,stimParams);

tVals=1:1000;
y0 = [0 0];
[t,y] = ode45(@(t,y) eqn_WCTsodyks(t,y,wcParams,stimParams),tVals,y0);

end

function [wcParams,stimParams] = defaultParams_Tsodyks

wcParams.Jee     = 2;
wcParams.Jei     = 4;
wcParams.taue    = 60;

wcParams.Jie     = 5;
wcParams.Jii     = 7;
wcParams.taui    = 12;

wcParams.theta   = 0;
wcParams.beta    = 1;

stimParams.e = 0;
stimParams.i = 1;
end