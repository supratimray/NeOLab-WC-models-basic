% Inputs
% paramsel: 
% 'P' - input to excitatory population
% 'Q' - input to inhibitory population
% 'c1' - equivalent to wee
% 'c2' - equivalent to wie
% 'c3' - equivalent to wei
% 'c4' - equivalent to wii

% modelType - 'full' or 'reduced'

function test_WC1972(paramsel,modelType)

if ~exist('modelType','var');       modelType='reduced';                end

[wcParams,stimParams] = defaultParams_WC1972(modelType); % Get default parameters 

% Generate quiver plot for default conditions
x=0:0.05:0.5;
IList = repmat(x,1,length(x));
EList = repmat(x,length(x),1); EList = EList(:);
UList = zeros(1,length(IList));
VList = zeros(1,length(IList));

for i=1:length(IList)
    dy = eqn_WC1972([],[EList(i) IList(i)],wcParams,stimParams);
    UList(i) = dy(1); VList(i) = dy(2);
end

% Factors to be tweaked
PList = stimParams.P + (0:0.1:0.5);
QList = stimParams.Q + (0:0.1:0.5);
c1List= wcParams.c1 + (-5:5);
c2List= wcParams.c2 + (-5:5);
c3List= wcParams.c3 + (-5:5);
c4List= wcParams.c4 + (-2:2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Simulate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tVals = 0:1000; % Simulation duration in ms
y0    = [0 0];

switch paramsel
    case 'P'
        varList=PList;    
    case 'Q'
        varList=QList;
    case 'c1'
        varList=c1List;    
    case 'c2'
        varList=c2List;
    case 'c3'
        varList=c3List;    
    case 'c4'
        varList=c4List;
end

numEntries = length(varList);
mList=cell(1,numEntries);
tList=cell(1,numEntries);

for i=1:numEntries
    disp([i numEntries]);
    if strcmp(paramsel,'P') || strcmp(paramsel,'Q')
        stimParams = setfield(stimParams,paramsel,varList(i)); %#ok<*SFLD>
    else
        wcParams = setfield(wcParams,paramsel,varList(i));
    end
    [t,y] = ode45(@(t,y) eqn_WC1972(t,y,wcParams,stimParams),tVals,y0);
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

function [wcParams,stimParams] = defaultParams_WC1972(modelType)

if strcmp(modelType,'full')
    % Default WC Parameters, set to get Figure 11 of the 1972 paper
    wcParams.ke     = 1;
    wcParams.re     = 1;
    wcParams.c1     = 16;
    wcParams.c2     = 12;
    wcParams.ae     = 1.3;
    wcParams.thetae = 4;
    wcParams.taue   = 8;
    
    wcParams.ki     = 1;
    wcParams.ri     = 1;
    wcParams.c3     = 15;
    wcParams.c4     = 3;
    wcParams.ai     = 2;
    wcParams.thetai = 3.7;
    wcParams.taui   = 8;
    
else
    % We get reduced equations by setting re and ri to zero.
    wcParams.ke     = 1; % 1
    wcParams.re     = 0; % 1
    wcParams.c1     = 16; % 16
    wcParams.c2     = 12; % 12
    wcParams.ae     = 1.3; % 1.3
    wcParams.thetae = 4; % 4
    wcParams.taue   = 8;
    
    wcParams.ki     = 1; % 1
    wcParams.ri     = 0; % 1
    wcParams.c3     = 15; % 15
    wcParams.c4     = 3; % 3
    wcParams.ai     = 2; % 2
    wcParams.thetai = 3.7; % 3.7
    wcParams.taui   = 8;
end

stimParams.P      = 1.25;
stimParams.Q      = 0;
end