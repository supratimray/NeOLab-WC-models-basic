function I = eNCEquation(E,wcParams,stimParams)

I = ((wcParams.Jee-1/wcParams.beta)*E - wcParams.theta + stimParams.e)/wcParams.Jei;
end

