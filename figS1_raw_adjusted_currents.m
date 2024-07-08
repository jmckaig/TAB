%% figS1_raw_adjusted_currents_10sec.m
clear all; close all; clc;

data = './data';

% Sample table
% Biomolecules
files.pUC19 = 'C3888_dsDNA1_S4_Dil_pUC19_5_ng_ul_20201018_14_20_19';
files.DNA1kb = 'C3888_dsDNA1_S1_Dil_DNA_1kb_0_2ng_ul_20201018_14_48_43';
files.DNAHR = 'C3888_dsDNA1_S2_DNA_HR_5_ng_ul_20201018_15_20_17';
files.ssRNA = 'C3884_RNA_E2_5_ssRNA_20210528_17_39_02';
files.dsRNA = 'C3884_RNA_Reagent_2_20210528_18_12_50';
files.ribosome = 'C3884_RNA_Reagent_3_20210528_18_40_53';
% Buffers
files.buf1 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_07_00'; % before pUC19
files.buf2 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_32_51'; % between pUC19 and DNA1kb
files.buf3 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_06_04'; % between DNA1kb and DNAHR
files.buf4 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_15_36_56'; % after DNAHR
files.buf5 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_16_59_58'; % new test date, before ssRNA
files.buf6 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_17_52_27'; % first buffer run after ssRNA and before dsRNA
files.buf7 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_02_55'; % second buffer run after ssRNA and before dsRNA
files.buf8 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_06_55'; % third buffer run after ssRNA and before dsRNA
files.buf9 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_26_52'; % first buffer run after dsRNA and before ribosome
files.buf10 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_31_46'; % second buffer run after dsRNA and before ribosome
files.buf11 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_36_31'; % third buffer run after dsRNA and before ribosome
files.buf12 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_53_28'; % first buffer run after ribosome
files.buf13 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_18_58_54'; % second buffer run after ribosome

fn = fieldnames(files);

for k=1:numel(fn)

    id = fn{k};
    Mat = fullfile(data,[files.(fn{k}) '.mat']);
    EventsMat = fullfile(data,[files.(fn{k}) '_events.mat']);
    load(Mat); 
    load(EventsMat); 

    % Get time vector and signal
    t = (1:numel(raw_data.samples_pA))/raw_data.sampling_rate_Hz;
    S = raw_data.samples_pA;

    % Estimate adjusted current
    msba = msbackadj(t',S','WindowSize',10,'StepSize',1);
    
    % Estimate baseline instead of adjusted current
    baseline_msba = S' - msba;
    
    % Plot raw data with overlaid events
    nanocounter_plot_raw_data_and_events(Mat,EventsMat);
    plot(t,baseline_msba,'k','LineWidth', 2);
    %title(id,'Raw Data');
    title('Raw Data');
    set(gca,'fontname','Helvetica','fontsize',20);
    
    % Remove outliers (signal) to be left with baseline and characterize as
    % Gaussian to get mean and standard deviation (noise)
    pd = fitdist(rmoutliers(msba),'normal');
    baseline = pd.mu;

    % Plot baseline-adjusted data with overlaid events
    nanocounter_plot_adj_data_and_events(Mat,EventsMat,msba,baseline);
    xlabel('Time (s)');
    ylabel('Current (pA)');
    %title(id,'Baseline-Adjusted Data');
    title('Baseline-Adjusted Data');
    set(gca,'fontname','Helvetica','fontsize',20);

    % Plot baseline-adjusted data without overlaid events for 70-80 seconds
    nanocounter_plot_adj_data(Mat,EventsMat,msba,baseline);
    xlabel('Time (s)');
    ylabel('Current (pA)');
    %title(id,'Baseline-Adjusted Data');
    title('Baseline-Adjusted Data');
    set(gca,'fontname','Helvetica','fontsize',20);
    xlim([70 80]);
    
end
