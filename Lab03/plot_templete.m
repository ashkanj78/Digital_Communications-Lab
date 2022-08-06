
%% Plot Template

freq = (0:frame_size-1)'/frame_size*fs - fs/2 + rx_fc;
time = (0:frame_size-1)'/fs;

rx_data_real = zeros(size(freq));
rx_data_imag = zeros(size(freq));
rx_fft_dBm = zeros(size(freq));
rx_fft_dBm_max = zeros(size(freq))-300;

fig1 = figure('units','normalized','outerposition',[0 0 1 1]);

sp1 = subplot(2,1,1);

p1 = plot(time*1e6, rx_data_real, 'Parent', sp1, 'DisplayName','Real RX Data', 'LineWidth' , 1);
hold all
p2 = plot(time*1e6, rx_data_real, 'Parent', sp1, 'DisplayName','Imag RX Data', 'LineWidth' , 1);
sp1.FontName = 'Calibri';
sp1.FontSize = 18;

p1.YDataSource = 'rx_data_real';
p2.YDataSource = 'rx_data_imag';

xlabel('Time (\mus)','FontSize',24,'FontName','Calibri')
ylabel('Volatage (V)','FontSize',24,'FontName','Calibri')
title('Time Domain Samples','FontSize',24,'FontName','Calibri')
xlim([min(time), max(time)]*1e6)
ylim([-1, 1])
legend show
grid on

sp2 = subplot(2,1,2, 'FontName','Calibri','FontSize',18);
p3 = plot(freq/1e6, rx_fft_dBm,'Parent', sp2, 'DisplayName','Instantanious Spectrum', 'LineWidth' , 1);
hold all
p4 = plot(freq/1e6, rx_fft_dBm_max, 'Parent', sp2, 'DisplayName','Max Hold', 'LineWidth' , 1);

p3.YDataSource = 'rx_fft_dBm';
p4.YDataSource = 'rx_fft_dBm_max';

sp2.FontName = 'Calibri';
sp2.FontSize = 18;

xlabel('Frequency (MHz)','FontSize',24,'FontName','Calibri')
ylabel('Power (dBm)','FontSize',24,'FontName','Calibri')
title('Spectrum','FontSize',24,'FontName','Calibri')
xlim([88, 108])
ylim([-160, -60])
legend show
grid on
    

%% Main
tic

while toc < stop_time
    rx_data = rx();
    rx_data_real = real(rx_data);
    rx_data_imag = imag(rx_data);
    rx_data_no_dc = rx_data - mean(rx_data);
 
    rx_fft = fftshift(fft(rx_data)/frame_size);
    rx_fft_dBm = 10*log10(abs(rx_fft).^2/(2*R)*1000) - rx_gain;
    rx_fft_dBm_max = max(rx_fft_dBm_max, rx_fft_dBm);
    refreshdata
    drawnow
end
