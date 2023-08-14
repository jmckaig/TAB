% fig3_ADGJ_DNA_event_examples.m

clear all; close all; clc;


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

% Set axes
set(gca,'ylim',[-250 100],'xlim',[0 3500]);

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

%% View example dsDNA_1kb event

% Clear previous biomolecule
clear

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
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Make figure and add data
figure('color',[1 1 1]);
plot(t*1E6,pA,'k','Linewidth',1.5);
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);
hold on;

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Set axes
set(gca,'ylim',[-150 100],'xlim',[0 3500]);


%% View example dsDNA_HR event

% Clear previous biomolecule
clear

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
signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Make figure and add data
figure('color',[1 1 1]);
plot(t*1E6,pA,'r','Linewidth',1.5);
xlabel('Event Time (µs)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);
hold on;

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Set axes
set(gca,'ylim',[-200 100],'xlim',[0 4000]);


%% Plot all together

% View example pUC19 event
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

% View example dsDNA_1kb event

% Clear previous biomolecule
clear

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

signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Make figure and add data
plot(t*1E6,pA,'k','Linewidth',1.5);
hold on;

% View example dsDNA_HR event

% Clear previous biomolecule
clear

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

signal_k = extracted_events{k}.event_signal;
fs = double(signal_k.sampling_rate_Hz);
pA = signal_k.samples_pA;
t = [1:numel(pA)]/double(fs);

% Make figure and add data
plot(t*1E6,pA,'r','Linewidth',1.5);
hold on;

% Add baseline
lw = 2;
baseline_y = zeros(1,length(t));
plot((t*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

% Add legend
legend('plasmid pUC19','1kb ladder','HR ladder','Location','southoutside','Orientation','horizontal');

% Set axes
set(gca,'ylim',[-250 100],'xlim',[0 3500]);

