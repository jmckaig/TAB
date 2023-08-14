% view_event.m

clear all; close all; clc;

%% Set sigma threshold
sigma_thresh = 3;

%% View example pUC19 event

event_number = 57;

% Load sample
sample = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
sample_name = 'pUC19';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot pUC19 event
lw = 2;
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Use detect_event function to get event stats
[event,stats]=detect_event(pA,sigma_thresh,false);

figure('color',[1 1 1]);

% add baseline (from custom event extraction)
plot(t*1E6,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E6,pA,'.-b');
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
hold on;

% Set title
title(sample_name,k);

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

% Set axes
set(gca,'ylim',[-250 100],'xlim',[0 3400]);

drawnow

%% View example dsDNA_1kb event

% Clear previous biomolecule and set sigma threshold
clear
sigma_thresh = 3;

event_number = 25;

% Load sample
sample = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
sample_name = 'DNA1kb';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot dsDNA_1kb event
lw = 2;
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Use detect_event function to get event stats
[event,stats]=detect_event(pA,sigma_thresh,false);

figure('color',[1 1 1]);

% add baseline (from custom event extraction)
plot(t*1E6,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E6,pA,'.-b');
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
hold on;

% Set title
title(sample_name);

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

% Set axes
set(gca,'ylim',[-150 100],'xlim',[0 3400]);

drawnow

%% View example dsDNA_HR event

% Clear previous biomolecule and set sigma threshold
clear
sigma_thresh = 3;

event_number = 10;

% Load sample
sample = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
sample_name = 'DNAHR';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot dsDNA_HR event
lw = 2;
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Use detect_event function to get event stats
[event,stats]=detect_event(pA,sigma_thresh,false);

figure('color',[1 1 1]);

% add baseline (from custom event extraction)
plot(t*1E6,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E6,pA,'.-b');
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
hold on;

% Set title
title(sample_name);

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

% Set axes
set(gca,'ylim',[-200 100],'xlim',[0 4000]);

drawnow

%% View example ssRNA event

% Clear previous biomolecule and set sigma threshold
clear
sigma_thresh = 3;

event_number = 642;

% Load sample
sample = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
sample_name = 'ssRNA';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot ssRNA event
lw = 2;
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Use detect_event function to get event stats
[event,stats]=detect_event(pA,sigma_thresh,false);

figure('color',[1 1 1]);

% add baseline (from custom event extraction)
plot(t*1E6,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E6,pA,'.-b');
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
hold on;

% Set title
title(sample_name);

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

drawnow

%% View example dsRNA event

% Clear previous biomolecule and set sigma threshold
clear
sigma_thresh = 3;

event_number = 2;

% Load sample
sample = 'C3884_RNA_Reagent_2_20210528_18_12_50';
sample_name = 'dsRNA';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot dsRNA event
lw = 2;
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Use detect_event function to get event stats
[event,stats]=detect_event(pA,sigma_thresh,false);

figure('color',[1 1 1]);

% add baseline (from custom event extraction)
plot(t*1E6,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E6,pA,'.-b');
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
hold on;

% Set title
title(sample_name);

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

drawnow

%% View example ribosome event

% Clear previous biomolecule and set sigma threshold
clear
sigma_thresh = 3;

event_number = 81;

% Load sample
sample = 'C3884_RNA_Reagent_3_20210528_18_40_53';
sample_name = 'ribosome';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot ribosome event
lw = 2;
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Use detect_event function to get event stats
[event,stats]=detect_event(pA,sigma_thresh,false);

figure('color',[1 1 1]);

% add baseline (from custom event extraction)
plot(t*1E6,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E6,pA,'.-b');
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
hold on;

% Set title
title(sample_name);

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

% Set axes
set(gca,'ylim',[-2200 300],'xlim',[0 3400]);

drawnow
