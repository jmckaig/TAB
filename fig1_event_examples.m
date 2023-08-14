% fig1_event_examples.m

clear all; close all; clc;

%% View example dsDNA_HR event

sigma_thresh = 3;

event_number = 3;

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
plot(t*1E3,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E3,pA,'.-b');
xlabel('Event Time (ms)');
ylabel('Ionic current (pA)');
hold on;

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

% Set axes
set(gca,'ylim',[-200 100],'xlim',[0 4.8]);

drawnow

%% View example ribosome event

% Clear previous biomolecule and set sigma threshold
clear
sigma_thresh = 3;

event_number = 1000;

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
plot(t*1E3,stats.mean_base_pA*ones(size(t)),'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add data
plot(t*1E3,pA,'.-b');
xlabel('Event Time (ms)');
ylabel('Ionic current (pA)');
hold on;

% Set fontsize
set(gca,'fontname','Helvetica','fontsize',20);

% Set axes
set(gca,'ylim',[-2200 500],'xlim',[0 4]);

drawnow
