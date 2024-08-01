% When you run fromm command window, open this file to edit
openInEditorPSW( mfilename('name') )%, "regrQEMG", "QEMG_RMN" )
clear, close all, % clc
figLibSet

 % EXAMPLE: Generate pink noise and display average spectral density.
      y = pinknoise(2^16,1e3);      % Generate 1000 channels of pink noise
      Y = fft(y);          % Compute the FFT of each channel of pink noise
      FS = 44100;          % Display assuming 44.1 kHz sample rate
      f = linspace(0,FS/2,size(y,1)/2);           % Frequency axis
      figure(figNext), nexttile;
      semilogx(f,db(mean(abs(Y(1:end/2,:)),2)),'c')   % Plot the response
      axis([1 FS/2 0 45]), grid on                % Set axis and grid
      title('Pink Noise Spectral Density (Averaged)')
      xlabel('Frequency (Hz)')
      ylabel('Power (dB)')
    
% figLib example      
x = y; fs = FS; sFq.log = 1;
nexttile, figFFT(x, fs, sFq); figPW hq

% figLibStop
% Finish for article? figPSW
