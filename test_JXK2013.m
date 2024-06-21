function [mList,tList]=test_JXK2013(paramsel,displayFlag)

eqnName = 'eqn_JXK2013';
[wcParams,stimParams] = defaultParams_JXK2013; % Get default parameters 

% Generate quiver plot for default conditions
x=0:15;
IList = repmat(x,1,length(x));
EList = repmat(x,length(x),1); EList = EList(:);
UList = zeros(1,length(IList));
VList = zeros(1,length(IList));

for i=1:length(IList)
    dy = eqn_JXK2013([],[EList(i) IList(i) 0],wcParams,stimParams);
    UList(i) = dy(1); VList(i) = dy(2);
end

% Factors to be tweaked
cList = [6.25 12.5 25 50 100]/100;
rList = 1:5;
weeList = wcParams.wee + (-0.5:0.1:0.5);
wieList = wcParams.wie + (-1:0.2:1);

weiList = wcParams.wei + (-1:0.2:1);
wiiList= wcParams.wii + (-0.5:0.1:0.5);
wegList= wcParams.weg + (-0.6:0.1:0.5);
% aieList= wcParams.aie + (-8:2:8);
% aeiList= wcParams.aei + (-8:2:8);
% aiiList= wcParams.aii + (-3:3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Simulate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tVals = 0:0.1:1600; % Simulation duration in ms
y0    = [0 0 0];

switch paramsel
    case 'c'
        varList=cList;    
    case 'r'
        varList=rList;
    case 'wee'
        varList=weeList;    
    case 'wei'
        varList=weiList;
    case 'wie'
        varList=wieList;    
    case 'wii'
        varList=wiiList;
    case 'weg'
        varList=wegList;
end

numEntries = length(varList);
mList=cell(1,numEntries);
tList=cell(1,numEntries);

for i=1:numEntries
    % disp([i numEntries]);
    if strcmp(paramsel,'c') || strcmp(paramsel,'r')
        stimParams = setfield(stimParams,paramsel,varList(i)); %#ok<*SFLD>
    else
        wcParams = setfield(wcParams,paramsel,varList(i));
    end
    [t,y] = eulerMethod(eqnName,tVals,y0,wcParams,stimParams);
    %[t,y] = ode45(@(t,y) eqn_JXK2013(t,y,wcParams,stimParams),tVals,y0);
    mList{i}=y;
    tList{i}=t;
end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Display %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if displayFlag
    colorNames=jet(numEntries);
    % subplot(221)
    % quiver(EList,IList,UList,VList); drawnow;
    % hold on; axis tight;
    % xlabel('E'); ylabel('I');
    
    for i=1:numEntries
        subplot(221)
        plot(mList{i}(:,1),mList{i}(:,2),'color',colorNames(i,:)); hold on;
        
        subplot(numEntries,2,2*i);
        plot(tList{i},mList{i}(:,1),'color',colorNames(i,:)); hold on;
        %plot(tList{i},mList{i}(:,2),'color','k');
        title([paramsel '=' num2str(varList(i))]);
    end
    
    subplot(223)
    analysisDuration = [500 1500];
    goodPos = intersect(find(t>=analysisDuration(1)),find(t<analysisDuration(2)));
    Fs=1000/(t(2)-t(1));
    dF = 1000/diff(analysisDuration);
    freqVals = 0:dF:Fs-dF;
    
    for i=1:numEntries
        x=mList{i}(goodPos,1);
        plot(freqVals,abs(fft(x-mean(x))),'color',colorNames(i,:)); hold on;
    end
    xlim([0 100]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
end
end

function [wcParams,stimParams] = defaultParams_JXK2013

wcParams.wee     = 1.5; %1.5;
wcParams.wie     = 3.25;
wcParams.taue    = 6;

wcParams.wei     = 3.5;
wcParams.wii     = 2.5;
wcParams.taui    = 15;

wcParams.wgi     = 0.5;
wcParams.wge     = 0.25;
wcParams.weg     = 0.6; %0.6;
wcParams.taug    = 19;

stimParams.MN = 0;
stimParams.theta = 0;
stimParams.r = 5;
stimParams.c = 1;
end