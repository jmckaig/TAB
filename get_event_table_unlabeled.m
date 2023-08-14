% get_event_table.m
% Extract features for each biomolecule class and output into ./features as an .xlsx file
    % Output columns 1-5: a1_pA, s1_pA, s3_pA, pot_sec, dwell_sec
    % Output columns 6-10: t12_sec, SNR, detection_threshold_pA, mean_amp_pA, mean_amp_nS
    % Output columns 11-15: max_amp_pA, max_amp_nS, med_amp_pA, std_amp_pA, area_pA_sec
    % Output columns 16-20: LFNmean_dBHz, LFNmedian_dBHz, applied_voltage_uV, BW_Hz, class_label
    % Output columns 21-24: t_rise_sec, pore_diam_nm, detected_event_num, extracted_event_num

clear all; close all; clc

%% load in biomolecule data
data = './data';

pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19'; % DNA plasmid puc19
DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43'; % DNA 1kb ladder
DNAhr = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17'; % DNA ladder high range
ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02'; % ssRNA ladder
dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50'; % dsRNA ladder
ribosome = 'C3884_RNA_Reagent_3_20210528_18_40_53'; % E. coli ribosome

%% extract pUC19 features and create an Excel file
% this code excludes event_signal (nested cell array)

load(fullfile(data,[pUC19 '.mat'])); % raw
load(fullfile(data,[pUC19 '_events.mat'])); % event

features_pUC19 = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_pUC19{k,1} = extracted_events{k}.a1_pA;
    features_pUC19{k,2} = extracted_events{k}.s1_pA;
    features_pUC19{k,3} = extracted_events{k}.s3_pA;
    features_pUC19{k,4} = extracted_events{k}.pot_sec;
    features_pUC19{k,5} = extracted_events{k}.dwell_sec;
    
    features_pUC19{k,6} = extracted_events{k}.t12_sec;
    features_pUC19{k,7} = extracted_events{k}.SNR;
    features_pUC19{k,8} = extracted_events{k}.detection_threshold_pA;
    features_pUC19{k,9} = extracted_events{k}.mean_amp_pA;
    features_pUC19{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_pUC19{k,11} = extracted_events{k}.max_amp_pA;
    features_pUC19{k,12} = extracted_events{k}.max_amp_nS;
    features_pUC19{k,13} = extracted_events{k}.med_amp_pA;
    features_pUC19{k,14} = extracted_events{k}.std_amp_pA;
    features_pUC19{k,15} = extracted_events{k}.area_pA_sec;
    
    features_pUC19{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_pUC19{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_pUC19{k,18} = extracted_events{k}.applied_voltage_uV;
    features_pUC19{k,19} = extracted_events{k}.BW_Hz;
    features_pUC19{k,20} = extracted_events{k}.class_label;
    
    features_pUC19{k,21} = extracted_events{k}.t_rise_sec;
    features_pUC19{k,22} = extracted_events{k}.pore_diam_nm;
    features_pUC19{k,23} = extracted_events{k}.detected_event_num;
    features_pUC19{k,24} = extracted_events{k}.extracted_event_num;
end

filename = 'features_pUC19.xlsx';
writecell(features_pUC19,filename);
movefile(filename, './machine_learning/features');

%% extract DNA1kb features and create an Excel file

load(fullfile(data,[DNA1kb '.mat'])); % raw
load(fullfile(data,[DNA1kb '_events.mat'])); % event

features_DNA1kb = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_DNA1kb{k,1} = extracted_events{k}.a1_pA;
    features_DNA1kb{k,2} = extracted_events{k}.s1_pA;
    features_DNA1kb{k,3} = extracted_events{k}.s3_pA;
    features_DNA1kb{k,4} = extracted_events{k}.pot_sec;
    features_DNA1kb{k,5} = extracted_events{k}.dwell_sec;
    
    features_DNA1kb{k,6} = extracted_events{k}.t12_sec;
    features_DNA1kb{k,7} = extracted_events{k}.SNR;
    features_DNA1kb{k,8} = extracted_events{k}.detection_threshold_pA;
    features_DNA1kb{k,9} = extracted_events{k}.mean_amp_pA;
    features_DNA1kb{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_DNA1kb{k,11} = extracted_events{k}.max_amp_pA;
    features_DNA1kb{k,12} = extracted_events{k}.max_amp_nS;
    features_DNA1kb{k,13} = extracted_events{k}.med_amp_pA;
    features_DNA1kb{k,14} = extracted_events{k}.std_amp_pA;
    features_DNA1kb{k,15} = extracted_events{k}.area_pA_sec;
    
    features_DNA1kb{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_DNA1kb{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_DNA1kb{k,18} = extracted_events{k}.applied_voltage_uV;
    features_DNA1kb{k,19} = extracted_events{k}.BW_Hz;
    features_DNA1kb{k,20} = extracted_events{k}.class_label;
    
    features_DNA1kb{k,21} = extracted_events{k}.t_rise_sec;
    features_DNA1kb{k,22} = extracted_events{k}.pore_diam_nm;
    features_DNA1kb{k,23} = extracted_events{k}.detected_event_num;
    features_DNA1kb{k,24} = extracted_events{k}.extracted_event_num;
end

filename = 'features_DNA1kb.xlsx';
writecell(features_DNA1kb,filename);
movefile(filename, './machine_learning/features');

%% extract DNAhr features and create an Excel file

load(fullfile(data,[DNAhr '.mat'])); % raw
load(fullfile(data,[DNAhr '_events.mat'])); % event

features_DNAhr = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_DNAhr{k,1} = extracted_events{k}.a1_pA;
    features_DNAhr{k,2} = extracted_events{k}.s1_pA;
    features_DNAhr{k,3} = extracted_events{k}.s3_pA;
    features_DNAhr{k,4} = extracted_events{k}.pot_sec;
    features_DNAhr{k,5} = extracted_events{k}.dwell_sec;
    
    features_DNAhr{k,6} = extracted_events{k}.t12_sec;
    features_DNAhr{k,7} = extracted_events{k}.SNR;
    features_DNAhr{k,8} = extracted_events{k}.detection_threshold_pA;
    features_DNAhr{k,9} = extracted_events{k}.mean_amp_pA;
    features_DNAhr{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_DNAhr{k,11} = extracted_events{k}.max_amp_pA;
    features_DNAhr{k,12} = extracted_events{k}.max_amp_nS;
    features_DNAhr{k,13} = extracted_events{k}.med_amp_pA;
    features_DNAhr{k,14} = extracted_events{k}.std_amp_pA;
    features_DNAhr{k,15} = extracted_events{k}.area_pA_sec;
    
    features_DNAhr{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_DNAhr{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_DNAhr{k,18} = extracted_events{k}.applied_voltage_uV;
    features_DNAhr{k,19} = extracted_events{k}.BW_Hz;
    features_DNAhr{k,20} = extracted_events{k}.class_label;
    
    features_DNAhr{k,21} = extracted_events{k}.t_rise_sec;
    features_DNAhr{k,22} = extracted_events{k}.pore_diam_nm;
    features_DNAhr{k,23} = extracted_events{k}.detected_event_num;
    features_DNAhr{k,24} = extracted_events{k}.extracted_event_num;
end

filename = 'features_DNAhr.xlsx';
writecell(features_DNAhr,filename);
movefile(filename, './machine_learning/features');

%% extract ssRNA features and create an Excel file

load(fullfile(data,[ssRNA '.mat'])); % raw
load(fullfile(data,[ssRNA '_events.mat'])); % event

features_ssRNA = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_ssRNA{k,1} = extracted_events{k}.a1_pA;
    features_ssRNA{k,2} = extracted_events{k}.s1_pA;
    features_ssRNA{k,3} = extracted_events{k}.s3_pA;
    features_ssRNA{k,4} = extracted_events{k}.pot_sec;
    features_ssRNA{k,5} = extracted_events{k}.dwell_sec;
    
    features_ssRNA{k,6} = extracted_events{k}.t12_sec;
    features_ssRNA{k,7} = extracted_events{k}.SNR;
    features_ssRNA{k,8} = extracted_events{k}.detection_threshold_pA;
    features_ssRNA{k,9} = extracted_events{k}.mean_amp_pA;
    features_ssRNA{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_ssRNA{k,11} = extracted_events{k}.max_amp_pA;
    features_ssRNA{k,12} = extracted_events{k}.max_amp_nS;
    features_ssRNA{k,13} = extracted_events{k}.med_amp_pA;
    features_ssRNA{k,14} = extracted_events{k}.std_amp_pA;
    features_ssRNA{k,15} = extracted_events{k}.area_pA_sec;
    
    features_ssRNA{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_ssRNA{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_ssRNA{k,18} = extracted_events{k}.applied_voltage_uV;
    features_ssRNA{k,19} = extracted_events{k}.BW_Hz;
    features_ssRNA{k,20} = extracted_events{k}.class_label;
    
    features_ssRNA{k,21} = extracted_events{k}.t_rise_sec;
    features_ssRNA{k,22} = extracted_events{k}.pore_diam_nm;
    features_ssRNA{k,23} = extracted_events{k}.detected_event_num;
    features_ssRNA{k,24} = extracted_events{k}.extracted_event_num;
end

filename = 'features_ssRNA.xlsx';
writecell(features_ssRNA,filename);
movefile(filename, './machine_learning/features');


%% extract dsRNA features and create an Excel file

load(fullfile(data,[dsRNA '.mat'])); % raw
load(fullfile(data,[dsRNA '_events.mat'])); % event

features_dsRNA = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_dsRNA{k,1} = extracted_events{k}.a1_pA;
    features_dsRNA{k,2} = extracted_events{k}.s1_pA;
    features_dsRNA{k,3} = extracted_events{k}.s3_pA;
    features_dsRNA{k,4} = extracted_events{k}.pot_sec;
    features_dsRNA{k,5} = extracted_events{k}.dwell_sec;
    
    features_dsRNA{k,6} = extracted_events{k}.t12_sec;
    features_dsRNA{k,7} = extracted_events{k}.SNR;
    features_dsRNA{k,8} = extracted_events{k}.detection_threshold_pA;
    features_dsRNA{k,9} = extracted_events{k}.mean_amp_pA;
    features_dsRNA{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_dsRNA{k,11} = extracted_events{k}.max_amp_pA;
    features_dsRNA{k,12} = extracted_events{k}.max_amp_nS;
    features_dsRNA{k,13} = extracted_events{k}.med_amp_pA;
    features_dsRNA{k,14} = extracted_events{k}.std_amp_pA;
    features_dsRNA{k,15} = extracted_events{k}.area_pA_sec;
    
    features_dsRNA{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_dsRNA{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_dsRNA{k,18} = extracted_events{k}.applied_voltage_uV;
    features_dsRNA{k,19} = extracted_events{k}.BW_Hz;
    features_dsRNA{k,20} = extracted_events{k}.class_label;
    
    features_dsRNA{k,21} = extracted_events{k}.t_rise_sec;
    features_dsRNA{k,22} = extracted_events{k}.pore_diam_nm;
    features_dsRNA{k,23} = extracted_events{k}.detected_event_num;
    features_dsRNA{k,24} = extracted_events{k}.extracted_event_num;
end

filename = 'features_dsRNA.xlsx';
writecell(features_dsRNA,filename);
movefile(filename, './machine_learning/features');


%% extract ribosome features and create an Excel file

load(fullfile(data,[ribosome '.mat'])); % raw
load(fullfile(data,[ribosome '_events.mat'])); % event

features_pUC19 = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_pUC19{k,1} = extracted_events{k}.a1_pA;
    features_pUC19{k,2} = extracted_events{k}.s1_pA;
    features_pUC19{k,3} = extracted_events{k}.s3_pA;
    features_pUC19{k,4} = extracted_events{k}.pot_sec;
    features_pUC19{k,5} = extracted_events{k}.dwell_sec;
    
    features_pUC19{k,6} = extracted_events{k}.t12_sec;
    features_pUC19{k,7} = extracted_events{k}.SNR;
    features_pUC19{k,8} = extracted_events{k}.detection_threshold_pA;
    features_pUC19{k,9} = extracted_events{k}.mean_amp_pA;
    features_pUC19{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_pUC19{k,11} = extracted_events{k}.max_amp_pA;
    features_pUC19{k,12} = extracted_events{k}.max_amp_nS;
    features_pUC19{k,13} = extracted_events{k}.med_amp_pA;
    features_pUC19{k,14} = extracted_events{k}.std_amp_pA;
    features_pUC19{k,15} = extracted_events{k}.area_pA_sec;
    
    features_pUC19{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_pUC19{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_pUC19{k,18} = extracted_events{k}.applied_voltage_uV;
    features_pUC19{k,19} = extracted_events{k}.BW_Hz;
    features_pUC19{k,20} = extracted_events{k}.class_label;
    
    features_pUC19{k,21} = extracted_events{k}.t_rise_sec;
    features_pUC19{k,22} = extracted_events{k}.pore_diam_nm;
    features_pUC19{k,23} = extracted_events{k}.detected_event_num;
    features_pUC19{k,24} = extracted_events{k}.extracted_event_num;
end

filename = 'features_ribosome.xlsx';
writecell(features_pUC19,filename);
movefile(filename, './machine_learning/features');
