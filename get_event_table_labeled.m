% get_event_table_labeled.m
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

%% Extract pUC19 features and create an Excel file
% this code excludes event_signal (nested cell array)

load(fullfile(data,[pUC19 '.mat'])); % raw
load(fullfile(data,[pUC19 '_events.mat'])); % event

features_pUC19_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_pUC19_array{k,1} = extracted_events{k}.a1_pA;
    features_pUC19_array{k,2} = extracted_events{k}.s1_pA;
    features_pUC19_array{k,3} = extracted_events{k}.s3_pA;
    features_pUC19_array{k,4} = extracted_events{k}.pot_sec;
    features_pUC19_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_pUC19_array{k,6} = extracted_events{k}.t12_sec;
    features_pUC19_array{k,7} = extracted_events{k}.SNR;
    features_pUC19_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_pUC19_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_pUC19_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_pUC19_array{k,11} = extracted_events{k}.max_amp_pA;
    features_pUC19_array{k,12} = extracted_events{k}.max_amp_nS;
    features_pUC19_array{k,13} = extracted_events{k}.med_amp_pA;
    features_pUC19_array{k,14} = extracted_events{k}.std_amp_pA;
    features_pUC19_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_pUC19_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_pUC19_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_pUC19_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_pUC19_array{k,19} = extracted_events{k}.BW_Hz;
    features_pUC19_array{k,20} = extracted_events{k}.class_label;
    
    features_pUC19_array{k,21} = extracted_events{k}.t_rise_sec;
    features_pUC19_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_pUC19_array{k,23} = extracted_events{k}.detected_event_num;
    features_pUC19_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_pUC19 = array2table(features_pUC19_array);
L = height(features_pUC19);

sample_column_pUC19 = cell(L,1);
sample_column_pUC19(1:L,1) = {'pUC19'};

features_pUC19_withsamplename = [features_pUC19 sample_column_pUC19];
features_pUC19_labeled = renamevars(features_pUC19_withsamplename,["features_pUC19_array1","features_pUC19_array2","features_pUC19_array3","features_pUC19_array4","features_pUC19_array5","features_pUC19_array6","features_pUC19_array7","features_pUC19_array8","features_pUC19_array9","features_pUC19_array10","features_pUC19_array11","features_pUC19_array12","features_pUC19_array13","features_pUC19_array14","features_pUC19_array15","features_pUC19_array16","features_pUC19_array17","features_pUC19_array18","features_pUC19_array19","features_pUC19_array20","features_pUC19_array21","features_pUC19_array22","features_pUC19_array23","features_pUC19_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);

filename = 'features_puc19_labeled.xlsx';
writetable(features_pUC19_labeled,filename);

movefile(filename, './machine_learning/features/labeled');

%% extract DNA1kb features and create an Excel file

load(fullfile(data,[DNA1kb '.mat'])); % raw
load(fullfile(data,[DNA1kb '_events.mat'])); % event

features_DNA1kb_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_DNA1kb_array{k,1} = extracted_events{k}.a1_pA;
    features_DNA1kb_array{k,2} = extracted_events{k}.s1_pA;
    features_DNA1kb_array{k,3} = extracted_events{k}.s3_pA;
    features_DNA1kb_array{k,4} = extracted_events{k}.pot_sec;
    features_DNA1kb_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_DNA1kb_array{k,6} = extracted_events{k}.t12_sec;
    features_DNA1kb_array{k,7} = extracted_events{k}.SNR;
    features_DNA1kb_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_DNA1kb_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_DNA1kb_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_DNA1kb_array{k,11} = extracted_events{k}.max_amp_pA;
    features_DNA1kb_array{k,12} = extracted_events{k}.max_amp_nS;
    features_DNA1kb_array{k,13} = extracted_events{k}.med_amp_pA;
    features_DNA1kb_array{k,14} = extracted_events{k}.std_amp_pA;
    features_DNA1kb_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_DNA1kb_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_DNA1kb_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_DNA1kb_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_DNA1kb_array{k,19} = extracted_events{k}.BW_Hz;
    features_DNA1kb_array{k,20} = extracted_events{k}.class_label;
    
    features_DNA1kb_array{k,21} = extracted_events{k}.t_rise_sec;
    features_DNA1kb_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_DNA1kb_array{k,23} = extracted_events{k}.detected_event_num;
    features_DNA1kb_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_DNA1kb = array2table(features_DNA1kb_array);
L = height(features_DNA1kb);

sample_column_DNA1kb = cell(L,1);
sample_column_DNA1kb(1:L,1) = {'DNA1kb'};

features_DNA1kb_withsamplename = [features_DNA1kb sample_column_DNA1kb];
features_DNA1kb_labeled = renamevars(features_DNA1kb_withsamplename,["features_DNA1kb_array1","features_DNA1kb_array2","features_DNA1kb_array3","features_DNA1kb_array4","features_DNA1kb_array5","features_DNA1kb_array6","features_DNA1kb_array7","features_DNA1kb_array8","features_DNA1kb_array9","features_DNA1kb_array10","features_DNA1kb_array11","features_DNA1kb_array12","features_DNA1kb_array13","features_DNA1kb_array14","features_DNA1kb_array15","features_DNA1kb_array16","features_DNA1kb_array17","features_DNA1kb_array18","features_DNA1kb_array19","features_DNA1kb_array20","features_DNA1kb_array21","features_DNA1kb_array22","features_DNA1kb_array23","features_DNA1kb_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);

filename = 'features_DNA1kb_labeled.xlsx';
writetable(features_DNA1kb_labeled,filename);

movefile(filename, './machine_learning/features/labeled');

%% extract DNAhr features and create an Excel file

load(fullfile(data,[DNAhr '.mat'])); % raw
load(fullfile(data,[DNAhr '_events.mat'])); % event

features_DNAhr_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_DNAhr_array{k,1} = extracted_events{k}.a1_pA;
    features_DNAhr_array{k,2} = extracted_events{k}.s1_pA;
    features_DNAhr_array{k,3} = extracted_events{k}.s3_pA;
    features_DNAhr_array{k,4} = extracted_events{k}.pot_sec;
    features_DNAhr_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_DNAhr_array{k,6} = extracted_events{k}.t12_sec;
    features_DNAhr_array{k,7} = extracted_events{k}.SNR;
    features_DNAhr_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_DNAhr_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_DNAhr_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_DNAhr_array{k,11} = extracted_events{k}.max_amp_pA;
    features_DNAhr_array{k,12} = extracted_events{k}.max_amp_nS;
    features_DNAhr_array{k,13} = extracted_events{k}.med_amp_pA;
    features_DNAhr_array{k,14} = extracted_events{k}.std_amp_pA;
    features_DNAhr_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_DNAhr_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_DNAhr_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_DNAhr_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_DNAhr_array{k,19} = extracted_events{k}.BW_Hz;
    features_DNAhr_array{k,20} = extracted_events{k}.class_label;
    
    features_DNAhr_array{k,21} = extracted_events{k}.t_rise_sec;
    features_DNAhr_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_DNAhr_array{k,23} = extracted_events{k}.detected_event_num;
    features_DNAhr_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_DNAhr = array2table(features_DNAhr_array);
L = height(features_DNAhr);

sample_column_DNAhr = cell(L,1);
sample_column_DNAhr(1:L,1) = {'DNAhr'};

features_DNAhr_withsamplename = [features_DNAhr sample_column_DNAhr];
features_DNAhr_labeled = renamevars(features_DNAhr_withsamplename,["features_DNAhr_array1","features_DNAhr_array2","features_DNAhr_array3","features_DNAhr_array4","features_DNAhr_array5","features_DNAhr_array6","features_DNAhr_array7","features_DNAhr_array8","features_DNAhr_array9","features_DNAhr_array10","features_DNAhr_array11","features_DNAhr_array12","features_DNAhr_array13","features_DNAhr_array14","features_DNAhr_array15","features_DNAhr_array16","features_DNAhr_array17","features_DNAhr_array18","features_DNAhr_array19","features_DNAhr_array20","features_DNAhr_array21","features_DNAhr_array22","features_DNAhr_array23","features_DNAhr_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);

filename = 'features_DNAhr_labeled.xlsx';
writetable(features_DNAhr_labeled,filename);

movefile(filename, './machine_learning/features/labeled');

%% extract ssRNA features and create an Excel file

load(fullfile(data,[ssRNA '.mat'])); % raw
load(fullfile(data,[ssRNA '_events.mat'])); % event

features_ssRNA_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_ssRNA_array{k,1} = extracted_events{k}.a1_pA;
    features_ssRNA_array{k,2} = extracted_events{k}.s1_pA;
    features_ssRNA_array{k,3} = extracted_events{k}.s3_pA;
    features_ssRNA_array{k,4} = extracted_events{k}.pot_sec;
    features_ssRNA_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_ssRNA_array{k,6} = extracted_events{k}.t12_sec;
    features_ssRNA_array{k,7} = extracted_events{k}.SNR;
    features_ssRNA_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_ssRNA_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_ssRNA_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_ssRNA_array{k,11} = extracted_events{k}.max_amp_pA;
    features_ssRNA_array{k,12} = extracted_events{k}.max_amp_nS;
    features_ssRNA_array{k,13} = extracted_events{k}.med_amp_pA;
    features_ssRNA_array{k,14} = extracted_events{k}.std_amp_pA;
    features_ssRNA_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_ssRNA_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_ssRNA_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_ssRNA_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_ssRNA_array{k,19} = extracted_events{k}.BW_Hz;
    features_ssRNA_array{k,20} = extracted_events{k}.class_label;
    
    features_ssRNA_array{k,21} = extracted_events{k}.t_rise_sec;
    features_ssRNA_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_ssRNA_array{k,23} = extracted_events{k}.detected_event_num;
    features_ssRNA_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_ssRNA = array2table(features_ssRNA_array);
L = height(features_ssRNA);
 
sample_column_ssRNA = cell(L,1);
sample_column_ssRNA(1:L,1) = {'ssRNA'};
 
features_ssRNA_withsamplename = [features_ssRNA sample_column_ssRNA];
features_ssRNA_labeled = renamevars(features_ssRNA_withsamplename,["features_ssRNA_array1","features_ssRNA_array2","features_ssRNA_array3","features_ssRNA_array4","features_ssRNA_array5","features_ssRNA_array6","features_ssRNA_array7","features_ssRNA_array8","features_ssRNA_array9","features_ssRNA_array10","features_ssRNA_array11","features_ssRNA_array12","features_ssRNA_array13","features_ssRNA_array14","features_ssRNA_array15","features_ssRNA_array16","features_ssRNA_array17","features_ssRNA_array18","features_ssRNA_array19","features_ssRNA_array20","features_ssRNA_array21","features_ssRNA_array22","features_ssRNA_array23","features_ssRNA_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_ssRNA_labeled.xlsx';
writetable(features_ssRNA_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');


%% extract dsRNA features and create an Excel file

load(fullfile(data,[dsRNA '.mat'])); % raw
load(fullfile(data,[dsRNA '_events.mat'])); % event

features_dsRNA_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_dsRNA_array{k,1} = extracted_events{k}.a1_pA;
    features_dsRNA_array{k,2} = extracted_events{k}.s1_pA;
    features_dsRNA_array{k,3} = extracted_events{k}.s3_pA;
    features_dsRNA_array{k,4} = extracted_events{k}.pot_sec;
    features_dsRNA_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_dsRNA_array{k,6} = extracted_events{k}.t12_sec;
    features_dsRNA_array{k,7} = extracted_events{k}.SNR;
    features_dsRNA_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_dsRNA_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_dsRNA_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_dsRNA_array{k,11} = extracted_events{k}.max_amp_pA;
    features_dsRNA_array{k,12} = extracted_events{k}.max_amp_nS;
    features_dsRNA_array{k,13} = extracted_events{k}.med_amp_pA;
    features_dsRNA_array{k,14} = extracted_events{k}.std_amp_pA;
    features_dsRNA_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_dsRNA_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_dsRNA_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_dsRNA_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_dsRNA_array{k,19} = extracted_events{k}.BW_Hz;
    features_dsRNA_array{k,20} = extracted_events{k}.class_label;
    
    features_dsRNA_array{k,21} = extracted_events{k}.t_rise_sec;
    features_dsRNA_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_dsRNA_array{k,23} = extracted_events{k}.detected_event_num;
    features_dsRNA_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_dsRNA = array2table(features_dsRNA_array);
L = height(features_dsRNA);
 
sample_column_dsRNA = cell(L,1);
sample_column_dsRNA(1:L,1) = {'dsRNA'};
 
features_dsRNA_withsamplename = [features_dsRNA sample_column_dsRNA];
features_dsRNA_labeled = renamevars(features_dsRNA_withsamplename,["features_dsRNA_array1","features_dsRNA_array2","features_dsRNA_array3","features_dsRNA_array4","features_dsRNA_array5","features_dsRNA_array6","features_dsRNA_array7","features_dsRNA_array8","features_dsRNA_array9","features_dsRNA_array10","features_dsRNA_array11","features_dsRNA_array12","features_dsRNA_array13","features_dsRNA_array14","features_dsRNA_array15","features_dsRNA_array16","features_dsRNA_array17","features_dsRNA_array18","features_dsRNA_array19","features_dsRNA_array20","features_dsRNA_array21","features_dsRNA_array22","features_dsRNA_array23","features_dsRNA_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_dsRNA_labeled.xlsx';
writetable(features_dsRNA_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');


%% extract ribosome features and create an Excel file

load(fullfile(data,[ribosome '.mat'])); % raw
load(fullfile(data,[ribosome '_events.mat'])); % event

features_ribosome_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_ribosome_array{k,1} = extracted_events{k}.a1_pA;
    features_ribosome_array{k,2} = extracted_events{k}.s1_pA;
    features_ribosome_array{k,3} = extracted_events{k}.s3_pA;
    features_ribosome_array{k,4} = extracted_events{k}.pot_sec;
    features_ribosome_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_ribosome_array{k,6} = extracted_events{k}.t12_sec;
    features_ribosome_array{k,7} = extracted_events{k}.SNR;
    features_ribosome_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_ribosome_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_ribosome_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_ribosome_array{k,11} = extracted_events{k}.max_amp_pA;
    features_ribosome_array{k,12} = extracted_events{k}.max_amp_nS;
    features_ribosome_array{k,13} = extracted_events{k}.med_amp_pA;
    features_ribosome_array{k,14} = extracted_events{k}.std_amp_pA;
    features_ribosome_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_ribosome_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_ribosome_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_ribosome_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_ribosome_array{k,19} = extracted_events{k}.BW_Hz;
    features_ribosome_array{k,20} = extracted_events{k}.class_label;
    
    features_ribosome_array{k,21} = extracted_events{k}.t_rise_sec;
    features_ribosome_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_ribosome_array{k,23} = extracted_events{k}.detected_event_num;
    features_ribosome_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_ribosome = array2table(features_ribosome_array);
L = height(features_ribosome);
 
sample_column_ribosome = cell(L,1);
sample_column_ribosome(1:L,1) = {'ribosome'};
 
features_ribosome_withsamplename = [features_ribosome sample_column_ribosome];
features_ribosome_labeled = renamevars(features_ribosome_withsamplename,["features_ribosome_array1","features_ribosome_array2","features_ribosome_array3","features_ribosome_array4","features_ribosome_array5","features_ribosome_array6","features_ribosome_array7","features_ribosome_array8","features_ribosome_array9","features_ribosome_array10","features_ribosome_array11","features_ribosome_array12","features_ribosome_array13","features_ribosome_array14","features_ribosome_array15","features_ribosome_array16","features_ribosome_array17","features_ribosome_array18","features_ribosome_array19","features_ribosome_array20","features_ribosome_array21","features_ribosome_array22","features_ribosome_array23","features_ribosome_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_ribosome_labeled.xlsx';
writetable(features_ribosome_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% concatenate labeled event tables

features_all_events_labeled = vertcat(features_pUC19_labeled,features_DNA1kb_labeled,features_DNAhr_labeled,features_ssRNA_labeled,features_dsRNA_labeled,features_ribosome_labeled);
filename = 'features_all_events_labeled.xlsx';
writetable(features_all_events_labeled,filename);
movefile(filename, './machine_learning/features/labeled');


%% ADD IN BUFFERS

%% load in buffer data
buf1 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_07_00'; % before pUC19
buf2 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_32_51'; % between pUC19 and DNA1kb
buf3 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_06_04'; % between DNA1kb and DNAHR
buf4 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_36_56'; % after DNAHR
buf5 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_16_59_58'; % new test date, before ssRNA
buf6 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_17_52_27'; % first buffer run after ssRNA and before dsRNA
buf7 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_02_55'; % second buffer run after ssRNA and before dsRNA
buf8 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_06_55'; % third buffer run after ssRNA and before dsRNA
buf9 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_26_52'; % first buffer run after dsRNA and before ribosome
buf10 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_31_46'; % second buffer run after dsRNA and before ribosome
buf11 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_36_31'; % third buffer run after dsRNA and before ribosome
buf12 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_53_28'; % first buffer run after ribosome
buf13 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_58_54'; % second buffer run after ribosome

%% extract buf1 features and create an Excel file

load(fullfile(data,[buf1 '.mat'])); % raw
load(fullfile(data,[buf1 '_events.mat'])); % event

features_buf1_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf1_array{k,1} = extracted_events{k}.a1_pA;
    features_buf1_array{k,2} = extracted_events{k}.s1_pA;
    features_buf1_array{k,3} = extracted_events{k}.s3_pA;
    features_buf1_array{k,4} = extracted_events{k}.pot_sec;
    features_buf1_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf1_array{k,6} = extracted_events{k}.t12_sec;
    features_buf1_array{k,7} = extracted_events{k}.SNR;
    features_buf1_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf1_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf1_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf1_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf1_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf1_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf1_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf1_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf1_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf1_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf1_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf1_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf1_array{k,20} = extracted_events{k}.class_label;
    
    features_buf1_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf1_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf1_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf1_array{k,24} = extracted_events{k}.extracted_event_num;
end

features_buf1 = array2table(features_buf1_array);
L = height(features_buf1);

sample_column_buf1 = cell(L,1);
sample_column_buf1(1:L,1) = {'buf1'};

features_buf1_withsamplename = [features_buf1 sample_column_buf1];
features_buf1_labeled = renamevars(features_buf1_withsamplename,["features_buf1_array1","features_buf1_array2","features_buf1_array3","features_buf1_array4","features_buf1_array5","features_buf1_array6","features_buf1_array7","features_buf1_array8","features_buf1_array9","features_buf1_array10","features_buf1_array11","features_buf1_array12","features_buf1_array13","features_buf1_array14","features_buf1_array15","features_buf1_array16","features_buf1_array17","features_buf1_array18","features_buf1_array19","features_buf1_array20","features_buf1_array21","features_buf1_array22","features_buf1_array23","features_buf1_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);

filename = 'features_buf1_labeled.xlsx';
writetable(features_buf1_labeled,filename);

movefile(filename, './machine_learning/features/labeled');

%% extract buf2 features and create an Excel file
 
load(fullfile(data,[buf2 '.mat'])); % raw
load(fullfile(data,[buf2 '_events.mat'])); % event
 
features_buf2_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf2_array{k,1} = extracted_events{k}.a1_pA;
    features_buf2_array{k,2} = extracted_events{k}.s1_pA;
    features_buf2_array{k,3} = extracted_events{k}.s3_pA;
    features_buf2_array{k,4} = extracted_events{k}.pot_sec;
    features_buf2_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf2_array{k,6} = extracted_events{k}.t12_sec;
    features_buf2_array{k,7} = extracted_events{k}.SNR;
    features_buf2_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf2_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf2_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf2_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf2_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf2_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf2_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf2_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf2_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf2_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf2_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf2_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf2_array{k,20} = extracted_events{k}.class_label;
    
    features_buf2_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf2_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf2_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf2_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf2 = array2table(features_buf2_array);
L = height(features_buf2);
 
sample_column_buf2 = cell(L,1);
sample_column_buf2(1:L,1) = {'buf2'};
 
features_buf2_withsamplename = [features_buf2 sample_column_buf2];
features_buf2_labeled = renamevars(features_buf2_withsamplename,["features_buf2_array1","features_buf2_array2","features_buf2_array3","features_buf2_array4","features_buf2_array5","features_buf2_array6","features_buf2_array7","features_buf2_array8","features_buf2_array9","features_buf2_array10","features_buf2_array11","features_buf2_array12","features_buf2_array13","features_buf2_array14","features_buf2_array15","features_buf2_array16","features_buf2_array17","features_buf2_array18","features_buf2_array19","features_buf2_array20","features_buf2_array21","features_buf2_array22","features_buf2_array23","features_buf2_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf2_labeled.xlsx';
writetable(features_buf2_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');


%% extract buf3 features and create an Excel file

load(fullfile(data,[buf3 '.mat'])); % raw
load(fullfile(data,[buf3 '_events.mat'])); % event
 
features_buf3_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf3_array{k,1} = extracted_events{k}.a1_pA;
    features_buf3_array{k,2} = extracted_events{k}.s1_pA;
    features_buf3_array{k,3} = extracted_events{k}.s3_pA;
    features_buf3_array{k,4} = extracted_events{k}.pot_sec;
    features_buf3_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf3_array{k,6} = extracted_events{k}.t12_sec;
    features_buf3_array{k,7} = extracted_events{k}.SNR;
    features_buf3_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf3_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf3_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf3_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf3_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf3_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf3_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf3_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf3_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf3_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf3_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf3_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf3_array{k,20} = extracted_events{k}.class_label;
    
    features_buf3_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf3_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf3_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf3_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf3 = array2table(features_buf3_array);
L = height(features_buf3);
 
sample_column_buf3 = cell(L,1);
sample_column_buf3(1:L,1) = {'buf3'};
 
features_buf3_withsamplename = [features_buf3 sample_column_buf3];
features_buf3_labeled = renamevars(features_buf3_withsamplename,["features_buf3_array1","features_buf3_array2","features_buf3_array3","features_buf3_array4","features_buf3_array5","features_buf3_array6","features_buf3_array7","features_buf3_array8","features_buf3_array9","features_buf3_array10","features_buf3_array11","features_buf3_array12","features_buf3_array13","features_buf3_array14","features_buf3_array15","features_buf3_array16","features_buf3_array17","features_buf3_array18","features_buf3_array19","features_buf3_array20","features_buf3_array21","features_buf3_array22","features_buf3_array23","features_buf3_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf3_labeled.xlsx';
writetable(features_buf3_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% extract buf4 features and create an Excel file

load(fullfile(data,[buf4 '.mat'])); % raw
load(fullfile(data,[buf4 '_events.mat'])); % event
 
features_buf4_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf4_array{k,1} = extracted_events{k}.a1_pA;
    features_buf4_array{k,2} = extracted_events{k}.s1_pA;
    features_buf4_array{k,3} = extracted_events{k}.s3_pA;
    features_buf4_array{k,4} = extracted_events{k}.pot_sec;
    features_buf4_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf4_array{k,6} = extracted_events{k}.t12_sec;
    features_buf4_array{k,7} = extracted_events{k}.SNR;
    features_buf4_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf4_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf4_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf4_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf4_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf4_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf4_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf4_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf4_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf4_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf4_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf4_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf4_array{k,20} = extracted_events{k}.class_label;
    
    features_buf4_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf4_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf4_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf4_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf4 = array2table(features_buf4_array);
L = height(features_buf4);
 
sample_column_buf4 = cell(L,1);
sample_column_buf4(1:L,1) = {'buf4'};
 
features_buf4_withsamplename = [features_buf4 sample_column_buf4];
features_buf4_labeled = renamevars(features_buf4_withsamplename,["features_buf4_array1","features_buf4_array2","features_buf4_array3","features_buf4_array4","features_buf4_array5","features_buf4_array6","features_buf4_array7","features_buf4_array8","features_buf4_array9","features_buf4_array10","features_buf4_array11","features_buf4_array12","features_buf4_array13","features_buf4_array14","features_buf4_array15","features_buf4_array16","features_buf4_array17","features_buf4_array18","features_buf4_array19","features_buf4_array20","features_buf4_array21","features_buf4_array22","features_buf4_array23","features_buf4_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf4_labeled.xlsx';
writetable(features_buf4_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% extract buf5 features and create an Excel file

load(fullfile(data,[buf5 '.mat'])); % raw
load(fullfile(data,[buf5 '_events.mat'])); % event
 
features_buf5_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf5_array{k,1} = extracted_events{k}.a1_pA;
    features_buf5_array{k,2} = extracted_events{k}.s1_pA;
    features_buf5_array{k,3} = extracted_events{k}.s3_pA;
    features_buf5_array{k,4} = extracted_events{k}.pot_sec;
    features_buf5_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf5_array{k,6} = extracted_events{k}.t12_sec;
    features_buf5_array{k,7} = extracted_events{k}.SNR;
    features_buf5_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf5_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf5_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf5_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf5_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf5_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf5_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf5_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf5_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf5_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf5_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf5_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf5_array{k,20} = extracted_events{k}.class_label;
    
    features_buf5_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf5_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf5_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf5_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf5 = array2table(features_buf5_array);
L = height(features_buf5);
 
sample_column_buf5 = cell(L,1);
sample_column_buf5(1:L,1) = {'buf5'};
 
features_buf5_withsamplename = [features_buf5 sample_column_buf5];
features_buf5_labeled = renamevars(features_buf5_withsamplename,["features_buf5_array1","features_buf5_array2","features_buf5_array3","features_buf5_array4","features_buf5_array5","features_buf5_array6","features_buf5_array7","features_buf5_array8","features_buf5_array9","features_buf5_array10","features_buf5_array11","features_buf5_array12","features_buf5_array13","features_buf5_array14","features_buf5_array15","features_buf5_array16","features_buf5_array17","features_buf5_array18","features_buf5_array19","features_buf5_array20","features_buf5_array21","features_buf5_array22","features_buf5_array23","features_buf5_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf5_labeled.xlsx';
writetable(features_buf5_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% extract buf6 features and create an Excel file

load(fullfile(data,[buf6 '.mat'])); % raw
load(fullfile(data,[buf6 '_events.mat'])); % event
 
features_buf6_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf6_array{k,1} = extracted_events{k}.a1_pA;
    features_buf6_array{k,2} = extracted_events{k}.s1_pA;
    features_buf6_array{k,3} = extracted_events{k}.s3_pA;
    features_buf6_array{k,4} = extracted_events{k}.pot_sec;
    features_buf6_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf6_array{k,6} = extracted_events{k}.t12_sec;
    features_buf6_array{k,7} = extracted_events{k}.SNR;
    features_buf6_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf6_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf6_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf6_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf6_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf6_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf6_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf6_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf6_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf6_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf6_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf6_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf6_array{k,20} = extracted_events{k}.class_label;
    
    features_buf6_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf6_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf6_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf6_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf6 = array2table(features_buf6_array);
L = height(features_buf6);
 
sample_column_buf6 = cell(L,1);
sample_column_buf6(1:L,1) = {'buf6'};
 
features_buf6_withsamplename = [features_buf6 sample_column_buf6];
features_buf6_labeled = renamevars(features_buf6_withsamplename,["features_buf6_array1","features_buf6_array2","features_buf6_array3","features_buf6_array4","features_buf6_array5","features_buf6_array6","features_buf6_array7","features_buf6_array8","features_buf6_array9","features_buf6_array10","features_buf6_array11","features_buf6_array12","features_buf6_array13","features_buf6_array14","features_buf6_array15","features_buf6_array16","features_buf6_array17","features_buf6_array18","features_buf6_array19","features_buf6_array20","features_buf6_array21","features_buf6_array22","features_buf6_array23","features_buf6_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf6_labeled.xlsx';
writetable(features_buf6_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');
 
%% extract buf7 features and create an Excel file

load(fullfile(data,[buf7 '.mat'])); % raw
load(fullfile(data,[buf7 '_events.mat'])); % event
 
features_buf7_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf7_array{k,1} = extracted_events{k}.a1_pA;
    features_buf7_array{k,2} = extracted_events{k}.s1_pA;
    features_buf7_array{k,3} = extracted_events{k}.s3_pA;
    features_buf7_array{k,4} = extracted_events{k}.pot_sec;
    features_buf7_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf7_array{k,6} = extracted_events{k}.t12_sec;
    features_buf7_array{k,7} = extracted_events{k}.SNR;
    features_buf7_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf7_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf7_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf7_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf7_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf7_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf7_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf7_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf7_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf7_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf7_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf7_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf7_array{k,20} = extracted_events{k}.class_label;
    
    features_buf7_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf7_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf7_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf7_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf7 = array2table(features_buf7_array);
L = height(features_buf7);
 
sample_column_buf7 = cell(L,1);
sample_column_buf7(1:L,1) = {'buf7'};
 
features_buf7_withsamplename = [features_buf7 sample_column_buf7];
features_buf7_labeled = renamevars(features_buf7_withsamplename,["features_buf7_array1","features_buf7_array2","features_buf7_array3","features_buf7_array4","features_buf7_array5","features_buf7_array6","features_buf7_array7","features_buf7_array8","features_buf7_array9","features_buf7_array10","features_buf7_array11","features_buf7_array12","features_buf7_array13","features_buf7_array14","features_buf7_array15","features_buf7_array16","features_buf7_array17","features_buf7_array18","features_buf7_array19","features_buf7_array20","features_buf7_array21","features_buf7_array22","features_buf7_array23","features_buf7_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf7_labeled.xlsx';
writetable(features_buf7_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');
 
%% extract buf8 features and create an Excel file

load(fullfile(data,[buf8 '.mat'])); % raw
load(fullfile(data,[buf8 '_events.mat'])); % event
 
features_buf8_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf8_array{k,1} = extracted_events{k}.a1_pA;
    features_buf8_array{k,2} = extracted_events{k}.s1_pA;
    features_buf8_array{k,3} = extracted_events{k}.s3_pA;
    features_buf8_array{k,4} = extracted_events{k}.pot_sec;
    features_buf8_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf8_array{k,6} = extracted_events{k}.t12_sec;
    features_buf8_array{k,7} = extracted_events{k}.SNR;
    features_buf8_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf8_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf8_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf8_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf8_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf8_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf8_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf8_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf8_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf8_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf8_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf8_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf8_array{k,20} = extracted_events{k}.class_label;
    
    features_buf8_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf8_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf8_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf8_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf8 = array2table(features_buf8_array);
L = height(features_buf8);
 
sample_column_buf8 = cell(L,1);
sample_column_buf8(1:L,1) = {'buf8'};
 
features_buf8_withsamplename = [features_buf8 sample_column_buf8];
features_buf8_labeled = renamevars(features_buf8_withsamplename,["features_buf8_array1","features_buf8_array2","features_buf8_array3","features_buf8_array4","features_buf8_array5","features_buf8_array6","features_buf8_array7","features_buf8_array8","features_buf8_array9","features_buf8_array10","features_buf8_array11","features_buf8_array12","features_buf8_array13","features_buf8_array14","features_buf8_array15","features_buf8_array16","features_buf8_array17","features_buf8_array18","features_buf8_array19","features_buf8_array20","features_buf8_array21","features_buf8_array22","features_buf8_array23","features_buf8_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf8_labeled.xlsx';
writetable(features_buf8_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% extract buf9 features and create an Excel file

load(fullfile(data,[buf9 '.mat'])); % raw
load(fullfile(data,[buf9 '_events.mat'])); % event
 
features_buf9_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf9_array{k,1} = extracted_events{k}.a1_pA;
    features_buf9_array{k,2} = extracted_events{k}.s1_pA;
    features_buf9_array{k,3} = extracted_events{k}.s3_pA;
    features_buf9_array{k,4} = extracted_events{k}.pot_sec;
    features_buf9_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf9_array{k,6} = extracted_events{k}.t12_sec;
    features_buf9_array{k,7} = extracted_events{k}.SNR;
    features_buf9_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf9_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf9_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf9_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf9_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf9_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf9_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf9_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf9_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf9_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf9_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf9_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf9_array{k,20} = extracted_events{k}.class_label;
    
    features_buf9_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf9_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf9_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf9_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf9 = array2table(features_buf9_array);
L = height(features_buf9);
 
sample_column_buf9 = cell(L,1);
sample_column_buf9(1:L,1) = {'buf9'};
 
features_buf9_withsamplename = [features_buf9 sample_column_buf9];
features_buf9_labeled = renamevars(features_buf9_withsamplename,["features_buf9_array1","features_buf9_array2","features_buf9_array3","features_buf9_array4","features_buf9_array5","features_buf9_array6","features_buf9_array7","features_buf9_array8","features_buf9_array9","features_buf9_array10","features_buf9_array11","features_buf9_array12","features_buf9_array13","features_buf9_array14","features_buf9_array15","features_buf9_array16","features_buf9_array17","features_buf9_array18","features_buf9_array19","features_buf9_array20","features_buf9_array21","features_buf9_array22","features_buf9_array23","features_buf9_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf9_labeled.xlsx';
writetable(features_buf9_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');
 
%% extract buf10 features and create an Excel file

load(fullfile(data,[buf10 '.mat'])); % raw
load(fullfile(data,[buf10 '_events.mat'])); % event
 
features_buf10_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf10_array{k,1} = extracted_events{k}.a1_pA;
    features_buf10_array{k,2} = extracted_events{k}.s1_pA;
    features_buf10_array{k,3} = extracted_events{k}.s3_pA;
    features_buf10_array{k,4} = extracted_events{k}.pot_sec;
    features_buf10_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf10_array{k,6} = extracted_events{k}.t12_sec;
    features_buf10_array{k,7} = extracted_events{k}.SNR;
    features_buf10_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf10_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf10_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf10_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf10_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf10_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf10_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf10_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf10_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf10_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf10_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf10_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf10_array{k,20} = extracted_events{k}.class_label;
    
    features_buf10_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf10_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf10_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf10_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf10 = array2table(features_buf10_array);
L = height(features_buf10);
 
sample_column_buf10 = cell(L,1);
sample_column_buf10(1:L,1) = {'buf10'};
 
features_buf10_withsamplename = [features_buf10 sample_column_buf10];
features_buf10_labeled = renamevars(features_buf10_withsamplename,["features_buf10_array1","features_buf10_array2","features_buf10_array3","features_buf10_array4","features_buf10_array5","features_buf10_array6","features_buf10_array7","features_buf10_array8","features_buf10_array9","features_buf10_array10","features_buf10_array11","features_buf10_array12","features_buf10_array13","features_buf10_array14","features_buf10_array15","features_buf10_array16","features_buf10_array17","features_buf10_array18","features_buf10_array19","features_buf10_array20","features_buf10_array21","features_buf10_array22","features_buf10_array23","features_buf10_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf10_labeled.xlsx';
writetable(features_buf10_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');
 
%% extract buf11 features and create an Excel file

load(fullfile(data,[buf11 '.mat'])); % raw
load(fullfile(data,[buf11 '_events.mat'])); % event
 
features_buf11_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf11_array{k,1} = extracted_events{k}.a1_pA;
    features_buf11_array{k,2} = extracted_events{k}.s1_pA;
    features_buf11_array{k,3} = extracted_events{k}.s3_pA;
    features_buf11_array{k,4} = extracted_events{k}.pot_sec;
    features_buf11_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf11_array{k,6} = extracted_events{k}.t12_sec;
    features_buf11_array{k,7} = extracted_events{k}.SNR;
    features_buf11_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf11_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf11_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf11_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf11_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf11_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf11_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf11_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf11_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf11_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf11_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf11_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf11_array{k,20} = extracted_events{k}.class_label;
    
    features_buf11_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf11_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf11_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf11_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf11 = array2table(features_buf11_array);
L = height(features_buf11);
 
sample_column_buf11 = cell(L,1);
sample_column_buf11(1:L,1) = {'buf11'};
 
features_buf11_withsamplename = [features_buf11 sample_column_buf11];
features_buf11_labeled = renamevars(features_buf11_withsamplename,["features_buf11_array1","features_buf11_array2","features_buf11_array3","features_buf11_array4","features_buf11_array5","features_buf11_array6","features_buf11_array7","features_buf11_array8","features_buf11_array9","features_buf11_array10","features_buf11_array11","features_buf11_array12","features_buf11_array13","features_buf11_array14","features_buf11_array15","features_buf11_array16","features_buf11_array17","features_buf11_array18","features_buf11_array19","features_buf11_array20","features_buf11_array21","features_buf11_array22","features_buf11_array23","features_buf11_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf11_labeled.xlsx';
writetable(features_buf11_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% extract buf12 features and create an Excel file

load(fullfile(data,[buf12 '.mat'])); % raw
load(fullfile(data,[buf12 '_events.mat'])); % event
 
features_buf12_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf12_array{k,1} = extracted_events{k}.a1_pA;
    features_buf12_array{k,2} = extracted_events{k}.s1_pA;
    features_buf12_array{k,3} = extracted_events{k}.s3_pA;
    features_buf12_array{k,4} = extracted_events{k}.pot_sec;
    features_buf12_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf12_array{k,6} = extracted_events{k}.t12_sec;
    features_buf12_array{k,7} = extracted_events{k}.SNR;
    features_buf12_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf12_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf12_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf12_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf12_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf12_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf12_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf12_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf12_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf12_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf12_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf12_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf12_array{k,20} = extracted_events{k}.class_label;
    
    features_buf12_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf12_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf12_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf12_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf12 = array2table(features_buf12_array);
L = height(features_buf12);
 
sample_column_buf12 = cell(L,1);
sample_column_buf12(1:L,1) = {'buf12'};
 
features_buf12_withsamplename = [features_buf12 sample_column_buf12];
features_buf12_labeled = renamevars(features_buf12_withsamplename,["features_buf12_array1","features_buf12_array2","features_buf12_array3","features_buf12_array4","features_buf12_array5","features_buf12_array6","features_buf12_array7","features_buf12_array8","features_buf12_array9","features_buf12_array10","features_buf12_array11","features_buf12_array12","features_buf12_array13","features_buf12_array14","features_buf12_array15","features_buf12_array16","features_buf12_array17","features_buf12_array18","features_buf12_array19","features_buf12_array20","features_buf12_array21","features_buf12_array22","features_buf12_array23","features_buf12_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf12_labeled.xlsx';
writetable(features_buf12_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');

%% extract buf13 features and create an Excel file

load(fullfile(data,[buf13 '.mat'])); % raw
load(fullfile(data,[buf13 '_events.mat'])); % event
 
features_buf13_array = cell(length(extracted_events),24);
for k = 1:length(extracted_events)
    features_buf13_array{k,1} = extracted_events{k}.a1_pA;
    features_buf13_array{k,2} = extracted_events{k}.s1_pA;
    features_buf13_array{k,3} = extracted_events{k}.s3_pA;
    features_buf13_array{k,4} = extracted_events{k}.pot_sec;
    features_buf13_array{k,5} = extracted_events{k}.dwell_sec;
    
    features_buf13_array{k,6} = extracted_events{k}.t12_sec;
    features_buf13_array{k,7} = extracted_events{k}.SNR;
    features_buf13_array{k,8} = extracted_events{k}.detection_threshold_pA;
    features_buf13_array{k,9} = extracted_events{k}.mean_amp_pA;
    features_buf13_array{k,10} = extracted_events{k}.mean_amp_nS;
    
    features_buf13_array{k,11} = extracted_events{k}.max_amp_pA;
    features_buf13_array{k,12} = extracted_events{k}.max_amp_nS;
    features_buf13_array{k,13} = extracted_events{k}.med_amp_pA;
    features_buf13_array{k,14} = extracted_events{k}.std_amp_pA;
    features_buf13_array{k,15} = extracted_events{k}.area_pA_sec;
    
    features_buf13_array{k,16} = extracted_events{k}.LFNmean_dBHz;
    features_buf13_array{k,17} = extracted_events{k}.LFNmedian_dBHz;
    % excluding event_signal
    features_buf13_array{k,18} = extracted_events{k}.applied_voltage_uV;
    features_buf13_array{k,19} = extracted_events{k}.BW_Hz;
    features_buf13_array{k,20} = extracted_events{k}.class_label;
    
    features_buf13_array{k,21} = extracted_events{k}.t_rise_sec;
    features_buf13_array{k,22} = extracted_events{k}.pore_diam_nm;
    features_buf13_array{k,23} = extracted_events{k}.detected_event_num;
    features_buf13_array{k,24} = extracted_events{k}.extracted_event_num;
end
 
features_buf13 = array2table(features_buf13_array);
L = height(features_buf13);
 
sample_column_buf13 = cell(L,1);
sample_column_buf13(1:L,1) = {'buf13'};
 
features_buf13_withsamplename = [features_buf13 sample_column_buf13];
features_buf13_labeled = renamevars(features_buf13_withsamplename,["features_buf13_array1","features_buf13_array2","features_buf13_array3","features_buf13_array4","features_buf13_array5","features_buf13_array6","features_buf13_array7","features_buf13_array8","features_buf13_array9","features_buf13_array10","features_buf13_array11","features_buf13_array12","features_buf13_array13","features_buf13_array14","features_buf13_array15","features_buf13_array16","features_buf13_array17","features_buf13_array18","features_buf13_array19","features_buf13_array20","features_buf13_array21","features_buf13_array22","features_buf13_array23","features_buf13_array24","Var25"],["a1_pA","s1_pA","s3_pA","pot_sec","dwell_sec","t12_sec","SNR","detection_threshold_pA","mean_amp_pA","mean_amp_nS","max_amp_pA","max_amp_nS","med_amp_pA","std_amp_pA","area_pA_sec","LFNmean_dBHz","LFNmedian_dBHz","applied_voltage_uV","BW_Hz","class_label","t_rise_sec","pore_diam_nm","detected_event_num","extracted_event_num","sample_name"]);
 
filename = 'features_buf13_labeled.xlsx';
writetable(features_buf13_labeled,filename);
 
movefile(filename, './machine_learning/features/labeled');


%% concatenate events and export as excel file
features_all_events_and_buffers_labeled = vertcat(features_pUC19_labeled,features_DNA1kb_labeled,features_DNAhr_labeled,features_ssRNA_labeled,features_dsRNA_labeled,features_ribosome_labeled,features_buf1_labeled,features_buf2_labeled,features_buf3_labeled,features_buf4_labeled,features_buf5_labeled,features_buf6_labeled,features_buf7_labeled,features_buf8_labeled,features_buf9_labeled,features_buf10_labeled,features_buf11_labeled,features_buf12_labeled,features_buf13_labeled);
filename = 'features_all_events_and_buffers_labeled.xlsx';
writetable(features_all_events_and_buffers_labeled,filename);
movefile(filename, './machine_learning/features/labeled');

