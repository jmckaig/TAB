% [F,H] = nanocounter_plot_raw_data_and_events(RAW,EVENTS)
%
% Plots raw Ontera NanoCounter data from raw data MAT file RAW, and
% overlays extracted events from MAT file EVENTS. A handle to the figure
% is returned as F, and H contains handles to each plot object.
%
% Christopher E. Carr (cecarr@gatech.edu)
% 2021-09-19
%
function [f,h] = nanocounter_plot_raw_data_and_events(raw,events)
    if nargin<3, saveasfile = ''; end
    lw = 2;

    % Load raw data
    load(raw);
    
    % Load the extracted events
    load(events);
    
    % Get number of extracted events
    N_events = numel(extracted_events);
    
    % Get number of samples
    N = numel(raw_data.samples_pA);
    % Construct time vector t
    t = (1:N) / raw_data.sampling_rate_Hz;
    % Get the samples
    x = raw_data.samples_pA;

    % create a figure with a white background
    f = figure('color',[1 1 1]);
    % Plot the raw data
    h = NaN(N_events+1,1);
    h(1) = plot(t,x,'-b','Color',[0 0 1 0.2]); 
    xlim([min(t), max(t)]);
    hold on;
    
    % Plot extracted events as overlay
    for k=1:N_events
        E = nanocounter_event_get_absolute(extracted_events{k});
        h(k+1) = plot(E.absolute.t,E.absolute.samples_pA,'-r','Color',[1 0 0 0.2],'linewidth',lw);
    end
    
    xlabel('Time (s)');
    ylabel('Current (pA)');
end