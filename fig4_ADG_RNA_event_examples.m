% fig4_ADG_RNA_event_examples.m

clear all; close all; clc;

%% View example dsRNA event

event_number = 852;

% Load sample
sample = 'C3884_RNA_Reagent_2_20210528_18_12_50';
sample_name = 'dsRNA';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot dsRNA event
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Make figure and add data
figure('color',[1 1 1]);
plot(t*1E6,pA,'b','Linewidth',1.5);
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);
hold on;

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on;
set(gca,'xlim',[0 4500],'ylim',[-400 200]);

%% View example ssRNA event

clear;
event_number = 55;

% Load sample
sample = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
sample_name = 'ssRNA';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot ssRNA event
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Add data
figure('color',[1 1 1]);
plot(t*1E6,pA,'k','Linewidth',1.5);
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);
hold on;

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on;
set(gca,'xlim',[0 4500]);

%% Plot both on one graph

clear;

% Plot example dsRNA event
event_number = 852;

% Load sample
sample = 'C3884_RNA_Reagent_2_20210528_18_12_50';
sample_name = 'dsRNA';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot dsRNA event
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Make figure and add data
figure('color',[1 1 1]);
plot(t*1E6,pA,'b','Linewidth',1.5);
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);
hold on;

% View example ssRNA event
clear;
event_number = 55;

% Load sample
sample = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
sample_name = 'ssRNA';

load(fullfile('./data',[sample '.mat']));
load(fullfile('./data',[sample '_events.mat']));

% Look at the feature data associated with the k-th event in this sample
k = event_number;
event_k = extracted_events{k}

% Plot ssRNA event
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Add data
plot(t*1E6,pA,'k','Linewidth',1.5);
hold on;

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add legend
legend('dsRNA','ssRNA','Location','southoutside','Orientation','horizontal');

% Set axes
set(gca,'ylim',[-450 250],'xlim',[0 4500]);
