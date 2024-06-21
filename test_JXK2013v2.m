[~,tList]=test_JXK2013('r',0);
numEntries=length(tList);
t=tList{1};
analysisDuration = [500 1500];
goodPos = intersect(find(t>=analysisDuration(1)),find(t<analysisDuration(2)));
Fs=1000/(t(2)-t(1));
dF = 1000/diff(analysisDuration);
freqVals = 0:dF:Fs-dF;
    
for i=1:50
    disp(i);
    [mList,tList]=test_JXK2013('r',0);

    for j=1:numEntries
        x=mList{j}(goodPos,1);
        fftx(i,j,:) = abs(fft(x-mean(x)));
    end
end

colorNames=jet(numEntries);
meanFFTx = squeeze(mean(fftx,1));
for i=1:numEntries
    plot(freqVals,meanFFTx(i,:),'color',colorNames(i,:)); hold on;
end
xlim([0 100]);