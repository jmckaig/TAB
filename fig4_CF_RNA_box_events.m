% fig4_CF_RNA_box_events.m

clear all; close all; clc;

%% Plot dsRNA box events

% Load in data
sample_name = 'C3884_RNA_Reagent_2_20210528_18_12_50';
rect = [-3.7293 0.9638 1.0191 0.5611];
x = [0 1];
y = [-400 200];
alpha = 0.03;

% Filter for events within region of interest (ROI) and SNR
sample = load(fullfile('./data',[sample_name '_events.mat']));

% Set lower/upper bounds for delta conductance
field = 'mean_amp_nS';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);

bDGLow = sample.mean_amp_nS>rect(2);
bDGHigh = sample.mean_amp_nS<(rect(2)+rect(4));
bDG = bitand(bDGLow,bDGHigh);

% Set lower/upper bounds for delta time
field = 'dwell_sec';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);

bDTLow = sample.dwell_sec>(10^(rect(1)));
bDTHigh = sample.dwell_sec<(10^(rect(1)+rect(3)));
bDT = bitand(bDTLow,bDTHigh);

% Select events in ROI
box = bitand(bDG,bDT);

filt = sample;
filt.extracted_events = filt.extracted_events(box);
filt.mean_amp_nS = filt.mean_amp_nS(box);
filt.dwell_sec = filt.dwell_sec(box);

% plot events in ROI
nanocounter_plot_events(filt.extracted_events,'scaled','scaled_heatmap',alpha);
xlim(x);
ylim(y);
xlabel('Time (scaled)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);


%% Plot dsRNA box events

% Load in data
sample_name = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02'; 
rect = [-3.3981 1.4525 1.1338 0.7964];
x = [0 1];
y = [-600 200];
alpha = 0.025;

% Filter for events within region of interest (ROI) and SNR
sample = load(fullfile('./data',[sample_name '_events.mat']));

% Set lower/upper bounds for delta conductance
field = 'mean_amp_nS';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);

bDGLow = sample.mean_amp_nS>rect(2);
bDGHigh = sample.mean_amp_nS<(rect(2)+rect(4));
bDG = bitand(bDGLow,bDGHigh);

% Set lower/upper bounds for delta time
field = 'dwell_sec';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);

bDTLow = sample.dwell_sec>(10^(rect(1)));
bDTHigh = sample.dwell_sec<(10^(rect(1)+rect(3)));
bDT = bitand(bDTLow,bDTHigh);

% Select events in ROI
box = bitand(bDG,bDT);

filt = sample;
filt.extracted_events = filt.extracted_events(box);
filt.mean_amp_nS = filt.mean_amp_nS(box);
filt.dwell_sec = filt.dwell_sec(box);

% plot events in ROI
nanocounter_plot_events(filt.extracted_events,'scaled','scaled_heatmap',alpha);
xlim(x);
ylim(y);
xlabel('Time (scaled)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);


