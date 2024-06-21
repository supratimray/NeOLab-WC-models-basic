function test_WCErmentrout(paramsel)

[wcParams,stimParams] = defaultParams_WCErmentrout; % Get default parameters 

% Generate quiver plot for default conditions
x=0:0.05:1;
IList = repmat(x,1,length(x));
EList = repmat(x,length(x),1); EList = EList(:);
UList = zeros(1,length(IList));
VList = zeros(1,length(IList));

for i=1:length(IList)
    dy = eqn_WCErmentrout([],[EList(i) IList(i)],wcParams,stimParams);
    UList(i) = dy(1); VList(i) = dy(2);
end

% Factors to be tweaked
I_EList = stimParams.ie + (-1:0.2:1);
I_IList = stimParams.ii + (-2:2);
aeeList= wcParams.aee + (-5:5);
aieList= wcParams.aie + (-8:2:8);
aeiList= wcParams.aei + (-8:2:8);
aiiList= wcParams.aii + (-3:3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Simulate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tVals = 0:1000; % Simulation duration in ms
y0    = [0 0];

switch paramsel
    case 'ie'
        varList=I_EList;    
    case 'ii'
        varList=I_IList;
    case 'aee'
        varList=aeeList;    
    case 'aei'
        varList=aeiList;
    case 'aie'
        varList=aieList;    
    case 'aii'
        varList=aiiList;
end

numEntries = length(varList);
mList=cell(1,numEntries);
tList=cell(1,numEntries);

for i=1:numEntries
    disp([i numEntries]);
    if strcmp(paramsel,'ie') || strcmp(paramsel,'ii')
        stimParams = setfield(stimParams,paramsel,varList(i)); %#ok<*SFLD>
    else
        wcParams = setfield(wcParams,paramsel,varList(i));
    end
    [t,y] = ode45(@(t,y) eqn_WCErmentrout(t,y,wcParams,stimParams),tVals,y0);
    mList{i}=y;
    tList{i}=t;
end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Display %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
colorNames=jet(numEntries);
subplot(221)
quiver(EList,IList,UList,VList); drawnow;
hold on; axis tight;
xlabel('E'); ylabel('I');

for i=1:numEntries
    subplot(221)
    plot(mList{i}(:,1),mList{i}(:,2),'color',colorNames(i,:)); hold on;
    
    subplot(numEntries,2,2*i);
    plot(tList{i},mList{i}(:,1),'color',colorNames(i,:)); hold on;
    plot(tList{i},mList{i}(:,2),'color','k');
    title([paramsel '=' num2str(varList(i))]);
end

subplot(223)
analysisDuration = [500 1000];
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

function [wcParams,stimParams] = defaultParams_WCErmentrout

% Default WC Parameters, set to parameters that generate oscillations
wcParams.aee = 10; %10;
wcParams.aie = 8;
wcParams.aei = 12;
wcParams.aii = 3;
wcParams.ze = 0.2;
wcParams.zi = 4;
wcParams.etau = 8;
wcParams.itau = 8;

stimParams.ie = 2;
stimParams.ii = 0;
end