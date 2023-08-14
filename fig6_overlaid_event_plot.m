% fig6_overlaid_event_plot.m
% Plot conductance vs. dwell time for different DNA events and buffers 

clear all; close all; clc;
recordings = './data';

%% Plot all samples
% Sample table
files.ribosome = 'C3884_RNA_Reagent_3_20210528_18_40_53';
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';
fn = fieldnames(files);
symbols = 'vsd><o';
colors = [[0 0.4470 0.7410];[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];[0.4660 0.6740 0.1880];[0.6350 0.0780 0.1840]];

ms = 10;
alpha_edge = 0.4;
alpha_face = 0.5;

x_edges = [-Inf linspace(-5,-1,50) Inf]; % Time, log10(s)
y_edges = [-Inf linspace(0,7,50) Inf];   % \Delta Conductance, nS


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

    h = scatter(log10(dt),dG,ms,symbols(k),'MarkerEdgeColor',colors(k,:),'MarkerFaceColor',colors(k,:),'MarkerFaceAlpha',alpha_face,'MarkerEdgeAlpha',alpha_edge); hold on;
    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\n',fn{k},recording_time,N);
end

xlabel('Dwell time (log10(s))');
ylabel('\Delta Conductance (nS)');
xlim([-5.25 -.25]);
set(gca,'fontname','Helvetica','fontsize',20);
legend(fn)

%% Plot all samples except ribosome
clear all;
recordings = './data';

% Sample table
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';
fn = fieldnames(files);
symbols = 'sd><o';
colors = [[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];[0.4660 0.6740 0.1880];[0.6350 0.0780 0.1840]];

ms = 10;
alpha_edge = 0.4;
alpha_face = 0.5;

x_edges = [-Inf linspace(-5,-1,50) Inf]; % Time, log10(s)
y_edges = [-Inf linspace(0,7,50) Inf];   % \Delta Conductance, nS


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

    h = scatter(log10(dt),dG,ms,symbols(k),'MarkerEdgeColor',colors(k,:),'MarkerFaceColor',colors(k,:),'MarkerFaceAlpha',alpha_face,'MarkerEdgeAlpha',alpha_edge); hold on;
    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\n',fn{k},recording_time,N);
end

xlabel('Dwell time (log10(s))');
ylabel('\Delta Conductance (nS)');
xlim([-5.25 -.25]);
ylim([0 4]);
set(gca,'fontname','Helvetica','fontsize',20);
legend(fn)
