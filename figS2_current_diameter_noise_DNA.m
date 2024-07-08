%% figS2_current_diameter_noise_DNA.m

clear all; close all; clc;

data = './data';

% DNA and buffers
group = "Nanopore 1";
files.buf1 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_07_00';
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.buf2 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_32_51';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.buf3 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_06_04';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
files.buf4 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_36_56';

%%
fn = fieldnames(files);

t_all = [];
S_all =[];
pore_diam_all = [];
time_diam_all =[];
noise_all = [];
time_noise_all = [];

time_all = [];


for k=1:numel(fn)

    id = fn{k};
    Mat = fullfile(data,[files.(fn{k}) '.mat']);
    EventsMat = fullfile(data,[files.(fn{k}) '_events.mat']);
    load(Mat); 
    load(EventsMat);

    % Remove values where voltage is turned off
    samples = raw_data.samples_pA;
    voltage = raw_data.voltage_uV;

    cutoff = 90000;
    voltage_off = voltage < cutoff;
    samples(voltage_off) = NaN;
    samples_voltage_on = rmmissing(samples);
      
    % Get time vector and signal
    t = (1:numel(samples_voltage_on))/raw_data.sampling_rate_Hz;
    S = samples_voltage_on;

    % Trim 0.1 of a second from start or end if voltage was off 
    if length(samples_voltage_on) ~= length(samples)
        if voltage_off(1) == 1 % voltage is off at beginning of recording
            t = t(12501:end);
            S = S(12501:end);
        end
        if voltage_off(end) == 1 % voltage is off at end of recording
            t = t(1:end-12500);
            S = S(1:end-12500);
        end
    end

    % Convert t and S to columns
    t_col = reshape(t,[],1);
    S_col = reshape(S,[],1);

    % Start time vector at end of previous
    if k > 1
        l = t_all(end);
        t_col_corr = t_col + l;
    else
        t_col_corr = t_col;
    end

    % Add time vector and signal to t_all and S_all
    t_all = [t_all; t_col_corr];
    S_all = [S_all; S_col];


    % Add pore diameter
    pore_diam = [];
    time_diam = [];

    for i = 1:numel(extracted_events)
        event_diam = extracted_events{i}.pore_diam_nm;
        pore_diam = [pore_diam;event_diam];

        event_time = extracted_events{i}.t12_sec;
        time_diam = [time_diam;event_time];
    end

    % Correct pore diameter time values if needed
    if length(samples_voltage_on) ~= length(samples)
        if voltage_off(1) == 1 % voltage is off at beginning of recording
            time_off = (length(samples) - length(samples_voltage_on))/125000;
            time_diam = (time_diam-time_off);
        end
    end


    pore_diam_all = [pore_diam_all;pore_diam];

    % Start time vector at end of previous
    if k > 1
        time_diam_adj = time_diam + l;
    else
        time_diam_adj = time_diam;
    end

    time_diam_all = [time_diam_all;time_diam_adj];


    % Estimate adjusted current
    msba = msbackadj(t',S','WindowSize',10,'StepSize',1);
    
    % Remove outliers (signal) to be left with baseline and characterize as
    % Gaussian to get mean and standard deviation (noise)
    pd = fitdist(rmoutliers(msba),'normal');
    baseline = pd.mu;

    % Append noise and time values
    noise = pd.sigma;
    noise_all = [noise_all;noise;noise];
    
    time_noise_start = t_col_corr(1);
    time_noise_end = t_col_corr(end);
    time_noise_all = [time_noise_all;time_noise_start;time_noise_end];

    % Get time values for beginning of each time point
    time_all = [time_all;time_noise_start];
    
end


%% Generate plots

% Define lines
line_buf1 = time_all(1);
line_pUC19 = time_all(2);
line_buf2 = time_all(3);
line_DNA1kb = time_all(4);
line_buf3 = time_all(5);
line_DNAHR = time_all(6);
line_buf4 = time_all(7);

% Initialize current plot
figure('color',[1 1 1]);
box on;hold on;

% plot grey lines
xline(line_buf1, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
xline(line_pUC19, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf2, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_DNA1kb, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf3, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_DNAHR, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf4, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 

% plot current
plot(t_all,S_all);
set(gca,'fontname','Helvetica','fontsize',20);
title_current = group+' Current';
title(title_current);
xlabel('Cumulative Recording Time (s)');
ylabel('Current (pA)');
xlim([0, 2500]);

% Initialize diameter plot
figure('color',[1 1 1]);
box on;hold on;

% plot grey lines
xline(line_buf1, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
xline(line_pUC19, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf2, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_DNA1kb, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf3, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_DNAHR, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf4, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 

% plot pore diameter
plot(time_diam_all,pore_diam_all);
set(gca,'fontname','Helvetica','fontsize',20);
title_diam = group + ' Diameter';
title(title_diam);
xlabel('Cumulative Recording Time (s)');
ylabel('Pore Diameter (nm)');
xlim([0, 2500]);


% Initialize noise plot
figure('color',[1 1 1]);
box on;hold on;

% plot grey lines
xline(line_buf1, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
xline(line_pUC19, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf2, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_DNA1kb, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf3, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_DNAHR, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf4, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 

% plot noise
plot(time_noise_all,noise_all);
set(gca,'fontname','Helvetica','fontsize',20);
title_noise = group + ' Noise';
title(title_noise);
xlabel('Cumulative Recording Time (s)');
ylabel('Noise (standard deviation, pA)');
xlim([0, 2500]);

