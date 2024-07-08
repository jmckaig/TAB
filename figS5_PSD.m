%% PSD.m
clear all; close all; clc;

data = './data';

% Sample table
files.buf1 = 'C3888_dsDNA1_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20201018_14_07_00';
files.buf5 = 'C3884_RNA_Ontera_Start_Up_Buffer_2M_LiCl_2020_01_23_20210528_16_59_58';

fn = fieldnames(files);

alpha = 0.4;

for k=1

    id = fn{k};
    Mat = fullfile(data,[files.(fn{k}) '.mat']);
    EventsMat = fullfile(data,[files.(fn{k}) '_events.mat']);
    load(Mat); 
    load(EventsMat); 

    x = raw_data.samples_pA;
    N = length(x);
    fs = 125000;

    [pxx,f]=pwelch(x,(2^16),[],[],fs,'psd');
    

    figure('color',[1 1 1]);
    scatter(f(3:end),pxx(3:end),'ro','MarkerFaceAlpha',alpha,'MarkerEdgeColor','none','MarkerFaceColor','flat');

    set(gca, 'XScale', 'log', 'YScale', 'log');
    hold('on');
    xlabel("Frequency (kHz)")
    ylabel("Power Spectral Density (pA^2/Hz)");
    set(gca,'fontname','Helvetica','fontsize',15);

  end

  for k = 2
    id = fn{k};
    Mat = fullfile(data,[files.(fn{k}) '.mat']);
    EventsMat = fullfile(data,[files.(fn{k}) '_events.mat']);
    load(Mat); 
    load(EventsMat); 

    x = raw_data.samples_pA;
    N = length(x);
    fs = 125000;

    [pxx,f]=pwelch(x,(2^16),[],[],fs,'psd');
    
    scatter(f(3:end),pxx(3:end),'bo','MarkerFaceAlpha',alpha,'MarkerEdgeColor','none','MarkerFaceColor','flat');

  end

  legend('Nanopore 1','Nanopore 2');

