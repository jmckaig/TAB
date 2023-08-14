% fig3_K_heatmap_all_DNA.m
% Plot conductance vs dwell time for each DNA sample

clear all; close all; clc;

recordings = './data';

% Sample table
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';

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

xedges = linspace(-5, -1.5, 31);
yedges = linspace(0, 7, 31);

% get counts
% pUC19
dt_pUC19 = [dt_array{1}];
dG_pUC19 = [dG_array{1}];
counts_pUC19 = histcounts2(log10(dt_pUC19),dG_pUC19, xedges, yedges);
% 1kb
dt_1kb = [dt_array{2}];
dG_1kb = [dG_array{2}];
counts_1kb = histcounts2(log10(dt_1kb),dG_1kb,xedges,yedges);
% HR
dt_HR = [dt_array{3}];
dG_HR = [dG_array{3}];
counts_HR = histcounts2(log10(dt_HR),dG_HR,xedges,yedges);

% modify counts
% pUC19
col_sums_pUC19 = sum(counts_pUC19);
all_sums_pUC19 = sum(col_sums_pUC19);
normalized_pUC19 = counts_pUC19 ./ all_sums_pUC19;
normalized_toall_pUC19 = normalized_pUC19 ./ 3;
% 1kb
col_sums_1kb = sum(counts_1kb);
all_sums_1kb = sum(col_sums_1kb);
normalized_1kb = counts_1kb ./ all_sums_1kb;
normalized_toall_1kb = normalized_1kb ./ 3;
% HR
col_sums_HR = sum(counts_HR);
all_sums_HR = sum(col_sums_HR);
normalized_HR = counts_HR ./ all_sums_HR;
normalized_toall_HR = normalized_HR ./ 3;

% sum counts for all 3 classes
sum_all = normalized_toall_pUC19 + normalized_toall_1kb + normalized_toall_HR;

% plot
figure('color',[1 1 1]); 
weighted_hist = histogram2(log10(dt_all),dG_all,[30 30],'Normalization','probability','FaceColor','flat'); colorbar;
weighted_hist.BinCounts = sum_all
xlabel('Dwell time (log10(s))'); 
ylabel('\Delta Conductance (nS)');
xlim([-5 -1.5]);
ylim([0 7]);
set(gca,'fontname','Helvetica','fontsize',20);
view(2);
