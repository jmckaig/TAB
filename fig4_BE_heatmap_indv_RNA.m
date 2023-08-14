% fig4_BEH_heatmap_indv_RNA.m
% Plot conductance vs dwell time for each DNA sample

clear all; close all; clc;

%% Plot dsRNA heat map

recordings = './data';

files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';

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
xlim([-5 0]);
ylim([0 6]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);

% Draw rectangle
rect = [-3.7293 0.9638 1.0191 0.5611];
hold on;
drawrectangle('Position',rect,'Color','red','FaceAlpha',0,'InteractionsAllowed','none','Layer','front');

%% Plot ssRNA heat map

clear all;
recordings = './data';

files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';

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
xlim([-5 0]);
ylim([0 6]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);

% Draw rectangle
rect = [-3.3981 1.4525 1.1338 0.7964]; % ssRNA
hold on;
drawrectangle('Position',rect,'Color','red','FaceAlpha',0,'InteractionsAllowed','none','Layer','front');
