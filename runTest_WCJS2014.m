clear;

e0 = 0:1:20; lE=length(e0);
i0 = 0:1:20; lI=length(i0);

eFR = zeros(lE,lI);
iFR = zeros(lE,lI);
peakA = zeros(lE,lI);
peakFreq = zeros(lE,lI);
harmonicA = zeros(lE,lI);

for j=1:lE
    for k=1:lI
        disp([j k]);
        [eFR(j,k),iFR(j,k),peakA(j,k),peakFreq(j,k),harmonicA(j,k)] = test_WCJS2014(e0(j),i0(k),0);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
colormap jet

subplot(321)
pcolor(e0,i0,eFR'); shading interp; 
xlabel('iE'); ylabel('iI'); colorbar;
title('E firing rate');

subplot(322)
pcolor(e0,i0,iFR'); shading interp;
xlabel('iE'); ylabel('iI'); colorbar;
title('i Firing rate');

subplot(323)
pcolor(e0,i0,peakA'); shading interp;
xlabel('iE'); ylabel('iI'); colorbar;
title('Peak Amplitude');

subplot(324)
pcolor(e0,i0,peakFreq'); shading interp;
xlabel('iE'); ylabel('iI'); colorbar;
title('Peak Frequency (Hz)');

subplot(325)
pcolor(e0,i0,harmonicA'); shading interp;
xlabel('iE'); ylabel('iI'); colorbar;
title('Harmonic Amplitude');

subplot(326)
% powerRatio = (harmonicA' ./peakA');
% powerRatio(peakA'<2)=0;
% pcolor(e0,i0,powerRatio); shading interp;
% xlabel('iE'); ylabel('iI'); colorbar;
% title('Amplitude Ratio');