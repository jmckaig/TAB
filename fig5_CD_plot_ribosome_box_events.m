% fig5_CD_plot_ribosome_box_events.m

clear all; close all; clc;
sample_name = 'C3884_RNA_Reagent_3_20210528_18_40_53';

%% Plot events in box A (intact ribosomes)

rect = [-4.2150 5.7274 0.6960 7.3611];

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
bSNR = sample.SNR>10;
box = bitand(bitand(bDG,bDT),bSNR);

filt = sample;
filt.extracted_events = filt.extracted_events(box);
filt.mean_amp_nS = filt.mean_amp_nS(box);
filt.dwell_sec = filt.dwell_sec(box);

% plot events in ROI

alpha = 0.03;

nanocounter_plot_events(filt.extracted_events,'scaled','scaled_heatmap',alpha);
xlabel('Time (scaled)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);

xlim([0.05 1]);
ylim([-2500 100]);


%% Plot events in box B (ribosomal fragments)

clear all;
sample_name = 'C3884_RNA_Reagent_3_20210528_18_40_53';
rect = [-4.7550 1.2206 0.6360 3.0796];

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
bSNR = sample.SNR>10;
box = bitand(bitand(bDG,bDT),bSNR);

filt = sample;
filt.extracted_events = filt.extracted_events(box);
filt.mean_amp_nS = filt.mean_amp_nS(box);
filt.dwell_sec = filt.dwell_sec(box);

% plot events in ROI

alpha = 0.03;

nanocounter_plot_events(filt.extracted_events,'scaled','scaled_heatmap',alpha);
xlabel('Time (scaled)');
ylabel('Ionic current (pA)');
set(gca,'fontname','Helvetica','fontsize',20);

xlim([0.05 1]);
ylim([-800 100]);



