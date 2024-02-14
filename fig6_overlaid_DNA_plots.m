% fig6_overlaid_DNA_plots.m
% Plot conductance vs. dwell time for different DNA events and buffers 

%% Plot DNA samples

clear all; close all
recordings = './data';

% Sample table
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
fn = fieldnames(files);
symbols = 'o<s';
colors = [[0 0 1];[1 0 0];[1 .65 0]];

ms = 10;
alpha = 0.5;

for k=1:numel(fn)
    % load raw data and get recording time
    load(fullfile(recordings,[files.(fn{k}) '.mat']));
    recording_time = numel(raw_data.samples_pA)/raw_data.sampling_rate_Hz;
    % event data example
    load(fullfile(recordings,[files.(fn{k}) '_events.mat']));
    N = numel(extracted_events);
    dt = cellfun(@(x)(x.dwell_sec),extracted_events);
    dG = cellfun(@(x)(x.mean_amp_nS),extracted_events);
    pAs = cellfun(@(x)(x.area_pA_sec),extracted_events);
    SNR = cellfun(@(x)(x.SNR),extracted_events);

    % Conductance & Time Plot
    if k==1
        figure('color',[1 1 1]);
    end
    h = scatter(dt,dG,ms,symbols(k),'MarkerEdgeColor',colors(k,:),'MarkerFaceColor',colors(k,:),'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha); hold on;

    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\n',fn{k},recording_time,N);
end
set(gca,'xscale','log');
xlabel('Dwell time (s)');
ylabel('\Delta Conductance (nS)');
xlim([0.00001, 0.1]);
ylim([0, 7]);
set(gca,'fontname','Helvetica','fontsize',20);
title("DNA Samples");
legend(fn)


%% Plot DNA buffers only, larger icons, automatically set axes

clear all 
recordings = './data';

% Sample table
files.buf1 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_07_00';
files.buf2 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_32_51';
files.buf3 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_06_04';
files.buf4 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_36_56';
fn = fieldnames(files);
symbols = 'o<sd';
colors = [[0 0 1];[1 0 0];[1 0.65 0];[0 0 0]];

ms = 10;
alpha = 0.5;

for k=1:numel(fn)
    % load raw data and get recording time
    load(fullfile(recordings,[files.(fn{k}) '.mat']));
    recording_time = numel(raw_data.samples_pA)/raw_data.sampling_rate_Hz;
    % event data example
    load(fullfile(recordings,[files.(fn{k}) '_events.mat']));
    N = numel(extracted_events);
    dt = cellfun(@(x)(x.dwell_sec),extracted_events);
    dG = cellfun(@(x)(x.mean_amp_nS),extracted_events);
    pAs = cellfun(@(x)(x.area_pA_sec),extracted_events);
    SNR = cellfun(@(x)(x.SNR),extracted_events);

    % Conductance & Time Plot
    if k==1
        figure('color',[1 1 1]);
    end
    h = scatter(dt,dG,ms,symbols(k),'MarkerEdgeColor',colors(k,:),'MarkerFaceColor',colors(k,:),'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha); hold on;

    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\n',fn{k},recording_time,N);
end
set(gca,'xscale','log');
xlabel('Dwell time (s)');
ylabel('\Delta Conductance (nS)');
xlim([0.00001, 0.1]);
ylim([0, 7]);
set(gca,'fontname','Helvetica','fontsize',20);
title("DNA Buffers");
legend(fn)

