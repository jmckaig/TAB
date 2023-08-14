% fig3_CFI_DNA_box_events.m

clear all; close all; clc;

%% Plot pUC19 box events

sample_name = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
rect = [-3.8462 1.5256 0.1179 0.2112];
alpha = .2;
x = [0.05 1];
y = [-500 100];

% % % DNA 1kb
% sample_name = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
% rect = [-3.6467 0.7232 0.3899 0.3379];
% alpha = .2;
% x = [0.05 1];
% y = [-300 100];

% % DNA HR
% sample_name = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
% rect = [-2.6856 0.8499 0.0725 0.1689];
% alpha = .1;
% x = [0 1];
% y = [-400 100];

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

% Filter for events by SNR 
field = 'SNR';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);
bSNR = sample.SNR>5;
box = bitand(bitand(bDG,bDT),bSNR);

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


%% Plot 1 kb box events

clear all 
recordings = './data';

sample_name = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
rect = [-3.6467 0.7232 0.3899 0.3379];
alpha = .2;
x = [0.05 1];
y = [-300 100];

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

% Filter for events by SNR 
field = 'SNR';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);
bSNR = sample.SNR>5;
box = bitand(bitand(bDG,bDT),bSNR);

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


%% Plot HR box events

clear all 
recordings = './data';

sample_name = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
rect = [-2.6856 0.8499 0.0725 0.1689];
alpha = .1;
x = [0 1];
y = [-400 100];

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

% Filter for events by SNR 
field = 'SNR';
sample.(field) = cellfun(@(x)(double(x.(field))),sample.extracted_events);
bSNR = sample.SNR>5;
box = bitand(bitand(bDG,bDT),bSNR);

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
