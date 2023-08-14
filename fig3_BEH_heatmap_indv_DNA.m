% fig3_BEH_heatmap_indv_DNA.m
% Plot conductance vs dwell time for each DNA sample

clear all; close all; clc;

%% Plot pUC19 heat map

recordings = './data';

% Sample table
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';

fn = fieldnames(files);
symbols = 'sos<s>sd';
colors = [[0 0 0];[0 0 1];[0 0 0];[1 0 0];[0 0 0];[1 0.65 0];[0 0 0];[0.8 0.8 0]];

ms = 10;
alpha = 0.5;

x_edges = [-Inf linspace(-5,-1,50) Inf]; % Time, log10(s)
y_edges = [-Inf linspace(0,7,50) Inf];   % \Delta Conductance, nS

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

histogram2(log10(dt_all),dG_all,[30 30],'Normalization','probability','FaceColor','flat'); colorbar;
xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
xlim([-5 -1.5]);
ylim([0 7]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);

% Add rectange to indicate region of interest
rect = [-3.8462 1.5256 0.1179 0.2112];
hold on;
drawrectangle('Position',rect,'Color','red','FaceAlpha',0,'InteractionsAllowed','none','Layer','front');

%% Plot 1 kb heat map

% Clear previous sample
clear;
recordings = './data';

% Sample table
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';

fn = fieldnames(files);
symbols = 'sos<s>sd';
colors = [[0 0 0];[0 0 1];[0 0 0];[1 0 0];[0 0 0];[1 0.65 0];[0 0 0];[0.8 0.8 0]];

ms = 10;
alpha = 0.5;

x_edges = [-Inf linspace(-5,-1,50) Inf]; % Time, log10(s)
y_edges = [-Inf linspace(0,7,50) Inf];   % \Delta Conductance, nS

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

histogram2(log10(dt_all),dG_all,[30 30],'Normalization','probability','FaceColor','flat'); colorbar;
xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
xlim([-5 -1.5]);
ylim([0 7]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);

% Add rectange to indicate region of interest
rect = [-3.6467 0.7232 0.3899 0.3379];
hold on;
drawrectangle('Position',rect,'Color','red','FaceAlpha',0,'InteractionsAllowed','none','Layer','front');

%% Plot HR heat map

% Clear previous sample
clear;
recordings = './data';

% Sample table
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';

fn = fieldnames(files);
symbols = 'sos<s>sd';
colors = [[0 0 0];[0 0 1];[0 0 0];[1 0 0];[0 0 0];[1 0.65 0];[0 0 0];[0.8 0.8 0]];

ms = 10;
alpha = 0.5;

x_edges = [-Inf linspace(-5,-1,50) Inf]; % Time, log10(s)
y_edges = [-Inf linspace(0,7,50) Inf];   % \Delta Conductance, nS

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
histogram2(log10(dt_all),dG_all,[30 30],'Normalization','probability','FaceColor','flat'); colorbar;
xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
xlim([-5 -1.5]);
ylim([0 7]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);

% Add rectange to indicate region of interest
rect = [-2.6856 0.8499 0.0725 0.1689];
hold on;
drawrectangle('Position',rect,'Color','red','FaceAlpha',0,'InteractionsAllowed','none','Layer','front');
