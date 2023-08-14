% sample_information.m

clear all; close all; clc;
recordings = './data';

%% Load biomolecule runs

% DNA and associated buffers
files.buf1 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_07_00';
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.buf2 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_32_51';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.buf3 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_06_04';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
files.buf4 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_36_56';

% RNA, ribosome, and associated buffers
files.buf5 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_16_59_58';
files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
files.buf6 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_17_52_27';
files.buf7 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_02_55';
files.buf8 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_06_55';
files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';
files.buf9 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_26_52';
files.buf10 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_31_46';
files.buf11 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_36_31';
files.ribosome = 'C3884_RNA_Reagent_3_20210528_18_40_53';
files.buf12 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_53_28';
files.buf13 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_58_54';

fn = fieldnames(files);

%% View event count and run time for biomolecule samples

for k=1:numel(fn)
    % load raw data and get recording time
    load(fullfile(recordings,[files.(fn{k}) '.mat']));
    recording_time = numel(raw_data.samples_pA)/raw_data.sampling_rate_Hz;
    
    % load extracted event data and get number of events
    load(fullfile(recordings,[files.(fn{k}) '_events.mat']));
    N = numel(extracted_events);
    
    % calculate event rate
    events_per_minute = N/(recording_time/60);

    % extract initial and final nanopore diameter
    initial_diam = extracted_events{1,1}.pore_diam_nm;
    final_diam = extracted_events{end}.pore_diam_nm;
    
    fprintf('%s\tRecording Time:\t%0.5f\tEvents:\t%d\tEvents Per Minute:\t%s\tInitial Diameter (nm):\t%s\tFinal Diameter (nm):\t%s\n',fn{k},recording_time,N,events_per_minute,initial_diam,final_diam);

end