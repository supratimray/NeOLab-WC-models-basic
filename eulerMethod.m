function [tVals,yVals] = eulerMethod(eqnName,tVals,y0,wcParams,stimParams) %#ok<INUSD>

dt = tVals(2)-tVals(1);
yVals(:,1)=y0;
for i=2:length(tVals)
    y=yVals(:,i-1);
    dy = eval([eqnName '([],y,wcParams,stimParams);']);
    yVals(:,i) = yVals(:,i-1)+dy*dt;
end
tVals=tVals';
yVals=yVals';