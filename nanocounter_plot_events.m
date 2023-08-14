function [f,h]=nanocounter_plot_events(events,mode,fn,alpha)
    if nargin<4, alpha = 1; end
    if nargin<3, fn = ''; end
    if nargin<2, mode = 'elapsed'; end
    
    figure('color',[1 1 1]);
    c = [0 0 1 alpha];
    
    N_events = numel(events);
    for k=1:N_events
        event = events{k};
        e_start = event.event_signal.event_start_idx;
        e_end = event.event_signal.event_end_idx;
        x = event.event_signal.samples_pA(e_start:e_end);
        n = 1:numel(x);
        % absolute time
        t_abs = n./double(event.event_signal.sampling_rate_Hz);
        t_rel = n./numel(n);
        % absolute time
        if strcmpi(mode,'elapsed')
            plot(t_abs,x,'-','color',c); hold on;
        else % strcmp(mode,'scaled')
            plot(t_rel,x,'-','color',c); hold on;
        end
    end
    if strcmpi(mode,'elapsed'),
        xlabel('Time (s)');
    else % strcmp(mode,'scaled')
        xlabel('Time (scaled)');
    end
    ylabel('Current (pA)');
    if ~isempty(fn), saveas(gcf,fn); end
end
