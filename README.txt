# NeOLab-WC-models-basic

This is the basic version of the WC models that were first used in Krishnakumaran et al 2022, PLoS Comp Biol and Shirhatti et al., 2022, PLoS Biol. 
A more elaborate coding environment developed by R Krishnakumaran is availabe in NeOLab-WC-models.

% Equations used in various models are described in functions called eqn_{PaperName}
eqn_JXK2013 - Jia, Xing, Kohn, 2013
eqn_WC1972 - Wilson and Cowan, 1972
eqn_WCErmentrout - Ermentrout's model in ModelDB
eqn_WCJS2014 - Jadi and Sejnowski, 2014
eqn_WCTsodyks - Tsodyks, 1997. First paper on ISN.

% Codes that run the equations. Each paper used different input manipulations, so the codes vary a bit.
test_JXK2013('c',1) will generate plots in the JXK paper for varying contrast levels
test_JXK2013v2 is a script that runs test_JXK2013 for multiple iterations and shows averaged responses
test_WC1972('P') plots responses for varying excitation levels in the original WC model.
test_WCErmentrout('ie') plots responses for varying excitation levels in Ermentrout's model.
test_WCJS2014(10,10,1) plots responses for e0=10 and i0=10.
test_WCJS2014withLR(10,10,1,-0.4) allows the weights to be modified by the beta parameter set to -0.4 (used in Shirhatti et al., 2022)

runTest_WCJS2014 - runs test_WCJS2014 for different values of E0 and I0 to generate Fig 3 of Jadi and Sejnowski, 2014 and part of Figure 7 of Krishnakumaran et al., 2022.
runTest_WCJS2014withLR - allows us to generate Figure 8 of Shirhatti et al., 2022

% Generic functions
% describeDynamics - generates the phase-plane diagram along with nullclnies. Used by test_WCJS2014
% displayHarmonics - just plots a signal + harmonics as shown in Figure 4 of Krishnakumaran et al., 2022
% eulerMethod - solver used for the differential equations
% getGammaAndHarmonicProperties - computes peak gamma & harmonic amplitude and phase

% Not used anymore
% eNCEquation - E nullcline equation
% iNCEquation - I nullcline equation
% FHN - John Rinzel's code for reference
