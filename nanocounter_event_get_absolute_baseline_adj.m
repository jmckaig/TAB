% [E] = nanocounter_event_get_absolute_baseline_adj(EVENT)
%
% Modified version of nanocounter_event_get_absolute.m to include
% baseline-adjusted data.
% 
%
function E = nanocounter_event_get_absolute(event,msba,baseline)   
    % get center time of extracted event
    t_k_c = event.t12_sec;
    % get event signal data
    data_k = event.event_signal;
    % extract event
    e_k = data_k.samples_pA(data_k.event_start_idx:data_k.event_end_idx);
    % get number of elements in event signal
    n_k = numel(e_k);
    % get start and stop times
    %t_start_stop = double(t_k_c) + [-1 1]*(double(n_k)/2)/double(data_k.sampling_rate_Hz);
    t_start_stop = double(t_k_c) + [-1 (double(n_k-2))]/double(data_k.sampling_rate_Hz);
    % reconstruct time vector
    t_k = linspace(t_start_stop(1),t_start_stop(2),n_k);
    % Return the event with augmented information
    E = event;
    %E.absolute.samples_pA = e_k+event.a1_pA;
    %E.absolute.samples_pA = e_k;
    E.absolute.samples_pA = e_k-baseline;
    E.absolute.t = t_k;
    E.absolute.n = t_k*double(data_k.sampling_rate_Hz);
end
