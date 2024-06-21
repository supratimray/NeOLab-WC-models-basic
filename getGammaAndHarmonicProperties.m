% This program does the following

% 1. Computes the power spectral density of the signal 
% 2. Find the maximum power in the range specified by gammaRange. That is the peak gamma frequency
% 3. Compute the power in a band around the peak frequency specified by gammaBandWidth
% 4. Find the maximum power near 2xpeakGammaFreq. Find the peak harmonic power in the same way as step 3
% 5. Band-pass filter the signal around gamma and harmonic peak frequencies
% 6. Compute the analytic signals using hilbet tranform and get the phases

function [peakGammaFreq,gammaAmp,harmonicAmp,gammaPhase, harmonicPhase]=getGammaAndHarmonicProperties(x,gammaRangeHz,gammaBandwidthHz,tMS)

if ~exist('gammaRangeHz','var');        gammaRangeHz = [30 75];         end
if ~exist('gammaBandwidthHz','var');    gammaBandwidthHz = 10;          end

Fs = round(1000./(tMS(2)-tMS(1)));
T  = length(tMS)/1000; % Duration in seconds
freqVals = 0:1/T:(Fs-1/T);

fftx = fft(x);
gammaRangePos = intersect(find(freqVals>=gammaRangeHz(1)),find(freqVals<gammaRangeHz(2)));
fftGamma = fftx(gammaRangePos);
gammaAmp = max(abs(fftGamma));
gammaPos = gammaRangePos(find(abs(fftGamma)==gammaAmp,1));
peakGammaFreq = freqVals(gammaPos);
harmonicFreq = 2*peakGammaFreq;
harmonicPos = (freqVals==harmonicFreq);
harmonicAmp = abs(fftx(harmonicPos));

gammaPhase = angle(fftx(gammaPos));
harmonicPhase = angle(fftx(harmonicPos));

end