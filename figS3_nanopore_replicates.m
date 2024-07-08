% figSX_nanopore_replicates.m
% Plot conductance vs dwell time for each DNA sample

clear all; close all; clc;

%% DNA_1kb_np1

clear;
recordings = './data';

% Sample table - file name and title
files.DNA1kb_np1= 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
data = 'DNA 1kb ladder, Nanopore 1';

fn = fieldnames(files);
symbols = 'sos<s>sd';
colors = [[0 0 0];[0 0 1];[0 0 0];[1 0 0];[0 0 0];[1 0.65 0];[0 0 0];[0.8 0.8 0]];

ms = 10;
alpha = 0.5;

for k=1:numel(fn)
    load(fullfile(recordings,[files.(fn{k}) '.mat']));
    recording_time = numel(raw_data.samples_pA)/raw_data.sampling_rate_Hz;

    load(fullfile(recordings,[files.(fn{k}) '_events.mat']));
    N = numel(extracted_events);
    dt = cellfun(@(x)(x.dwell_sec),extracted_events);
    dG = cellfun(@(x)(x.mean_amp_nS),extracted_events);
    pAs = cellfun(@(x)(x.area_pA_sec),extracted_events);
    SNR = cellfun(@(x)(x.SNR),extracted_events);
    
    dt_array{k}=dt;
    dG_array{k}=dG;
    pAs_array{k}=pAs;
    SNR_array{k}=SNR;
    label_array{k}=repmat(fn(k),size(dt));

    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\n',fn{k},recording_time,N);

end

dt_all = [dt_array{:}];
dG_all = [dG_array{:}];
pAs_all = [pAs_array{:}];
SNR_all = [SNR_array{:}];
labels_all = [label_array{:}];
X = [dt_all' dG_all' pAs_all' SNR_all'];


% Generate weighted conductance vs. time heat map
figure('color',[1 1 1]); 
histogram2(log10(dt_all),dG_all,'Normalization','probability','FaceColor','flat'); colorbar;
xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
xlim([-5 0]);
ylim([0 7.5]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);

%% DNA_1kb_np2

% Clear previous sample
clear;
recordings = './data';

% Sample table - file name and title
files.DNA1kb_np2= 'C3891_C3891_Reagent_1_20240430_15_59_23';
data = 'DNA 1kb ladder, Nanopore 2';

fn = fieldnames(files);
symbols = 'sos<s>sd';
colors = [[0 0 0];[0 0 1];[0 0 0];[1 0 0];[0 0 0];[1 0.65 0];[0 0 0];[0.8 0.8 0]];

ms = 10;
alpha = 0.5;

for k=1:numel(fn)
    load(fullfile(recordings,[files.(fn{k}) '.mat']));
    recording_time = numel(raw_data.samples_pA)/raw_data.sampling_rate_Hz;

    load(fullfile(recordings,[files.(fn{k}) '_events.mat']));
    N = numel(extracted_events);
    dt = cellfun(@(x)(x.dwell_sec),extracted_events);
    dG = cellfun(@(x)(x.mean_amp_nS),extracted_events);
    pAs = cellfun(@(x)(x.area_pA_sec),extracted_events);
    SNR = cellfun(@(x)(x.SNR),extracted_events);
    
    dt_array{k}=dt;
    dG_array{k}=dG;
    pAs_array{k}=pAs;
    SNR_array{k}=SNR;
    label_array{k}=repmat(fn(k),size(dt));

    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\n',fn{k},recording_time,N);

end

dt_all = [dt_array{:}];
dG_all = [dG_array{:}];
pAs_all = [pAs_array{:}];
SNR_all = [SNR_array{:}];
labels_all = [label_array{:}];
X = [dt_all' dG_all' pAs_all' SNR_all'];

% Generate weighted conductance vs. time heat map
figure('color',[1 1 1]); 
histogram2(log10(dt_all),dG_all,'Normalization','probability','FaceColor','flat'); colorbar;

xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
xlim([-5 0]);
ylim([0 7.5]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);
