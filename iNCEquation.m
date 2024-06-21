function I = iNCEquation(E,wcParams,stimParams)

I = (wcParams.Jie*E - wcParams.theta + stimParams.i)/((1/wcParams.beta) + wcParams.Jii);
end

