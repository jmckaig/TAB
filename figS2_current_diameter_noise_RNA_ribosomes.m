%% figS2_current_diameter_noise_RNA_ribosomes.m

clear all; close all; clc;

data = './data';

% RNA, ribosome, and buffers
group = "Nanopore 2";
files.buf5 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_16_59_58'; % new test date, before ssRNA
files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
files.buf6 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_17_52_27'; % first buffer run after ssRNA and before dsRNA
files.buf7 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_02_55'; % second buffer run after ssRNA and before dsRNA
files.buf8 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_06_55'; % third buffer run after ssRNA and before dsRNA
files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';
files.buf9 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_26_52'; % first buffer run after dsRNA and before ribosome
files.buf10 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_31_46'; % second buffer run after dsRNA and before ribosome
files.buf11 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_36_31'; % third buffer run after dsRNA and before ribosome
files.ribosome = 'C3884_RNA_Reagent_3_20210528_18_40_53';
files.buf12 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_53_28'; % first buffer run after ribosome
files.buf13 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_58_54'; % second buffer run after ribosome

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

% define grey lines
line_buf5 = time_all(1);
line_ssRNA = time_all(2);
line_buf6 = time_all(3);
line_buf7 = time_all(4);
line_buf8 = time_all(5);
line_dsRNA = time_all(6);
line_buf9 = time_all(7);
line_buf10 = time_all(8);
line_buf11 = time_all(9);
line_ribosome = time_all(10);
line_buf12 = time_all(11);
line_buf13 = time_all(12);

% Initialize current plot
figure('color',[1 1 1]);
box on;hold on;

% plot grey lines
xline(line_buf5, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
xline(line_ssRNA, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf6, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf7, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf8, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_dsRNA, 'Color', [0.5 0.5 0.5],  'LineWidth', 1); 
xline(line_buf9, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf10, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf11, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_ribosome, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf12, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf13, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);

% plot current
plot(t_all,S_all);
set(gca,'fontname','Helvetica','fontsize',20);
title_current = group+' Current';
title(title_current);
xlabel('Cumulative Recording Time (s)');
ylabel('Current (pA)'); 
xlim([0, 3955]);


% Initialize diameter plot
figure('color',[1 1 1]);
box on; hold on;

% plot grey lines
xline(line_buf5, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
xline(line_ssRNA, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf6, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf7, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf8, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_dsRNA, 'Color', [0.5 0.5 0.5],  'LineWidth', 1); 
xline(line_buf9, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf10, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf11, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_ribosome, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf12, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf13, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 

% plot pore diameter
plot(time_diam_all,pore_diam_all);
set(gca,'fontname','Helvetica','fontsize',20);
title_diam = group + ' Diameter';
title(title_diam);
xlabel('Cumulative Recording Time (s)');
ylabel('Pore Diameter (nm)');
xlim([0, 3955]);


% Initialize noise plot
figure('color',[1 1 1]);
box on; hold on;

% plot grey lines
xline(line_buf5, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
xline(line_ssRNA, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf6, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf7, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf8, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_dsRNA, 'Color', [0.5 0.5 0.5],  'LineWidth', 1); 
xline(line_buf9, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf10, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf11, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_ribosome, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf12, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
xline(line_buf13, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 

% plot noise
plot(time_noise_all,noise_all);
set(gca,'fontname','Helvetica','fontsize',20);
title_noise = group + ' Noise';
title(title_noise);
xlabel('Cumulative Recording Time (s)');
ylabel('Noise (standard deviation, pA)');
xlim([0, 3955]);
