H% fig4_H_heatmap_all_RNA.m
% Plot conductance vs dwell time for each DNA sample

clear all; close all; clc;

recordings = './data';

% Sample table
files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';

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

%% Generate weighted conductance vs. time heat map

xedges = linspace(-5, 0, 31);
yedges = linspace(0, 6, 31);

% get counts
% ssRNA
dt_ssRNA = [dt_array{1}];
dG_ssRNA = [dG_array{1}];
counts_ssRNA = histcounts2(log10(dt_ssRNA),dG_ssRNA, xedges, yedges);
% dsRNA
dt_dsRNA = [dt_array{2}];
dG_dsRNA = [dG_array{2}];
counts_dsRNA = histcounts2(log10(dt_dsRNA),dG_dsRNA,xedges,yedges);

% modify counts
% ssRNA
col_sums_ssRNA = sum(counts_ssRNA);
all_sums_ssRNA = sum(col_sums_ssRNA);
normalized_ssRNA = counts_ssRNA ./ all_sums_ssRNA;
normalized_toall_ssRNA = normalized_ssRNA ./ 3;
% dsRNA
col_sums_dsRNA = sum(counts_dsRNA);
all_sums_dsRNA = sum(col_sums_dsRNA);
normalized_dsRNA = counts_dsRNA ./ all_sums_dsRNA;
normalized_toall_dsRNA = normalized_dsRNA ./ 3;

% sum counts for all 2 classes
sum_all = normalized_toall_ssRNA + normalized_toall_dsRNA;

% plot
figure('color',[1 1 1]); 
weighted_hist = histogram2(log10(dt_all),dG_all,[30 30],'Normalization','probability','FaceColor','flat'); colorbar;
weighted_hist.BinCounts = sum_all
xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
set(gca,'fontname','Helvetica','fontsize',20);
view(2);
xlim([-5 0]);
ylim([0 6]);
