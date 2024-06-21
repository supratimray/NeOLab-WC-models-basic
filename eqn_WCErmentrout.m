% The WC differential equations used by Bard Ermentrout in ModelDB

function dy = eqn_WCErmentrout(~,y,wcParams,stimParams)

dy = zeros(2,1);
dy(1) = (-y(1) + fx(wcParams.aee*y(1) - wcParams.aie*y(2) - wcParams.ze + stimParams.ie))./wcParams.etau;
dy(2) = (-y(2) + fx(wcParams.aei*y(1) - wcParams.aii*y(2) - wcParams.zi + stimParams.ii))./wcParams.itau;
end

function f = fx(x)
f = 1/(1+exp(-x));
end