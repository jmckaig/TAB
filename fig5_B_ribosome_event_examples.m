% fig5_B_ribosome_event_examples.m

ribosome = load('./data/C3884_RNA_Reagent_3_20210528_18_40_53_events.mat');

figure('color',[1 1 1]);

selection_window = [-20 20];

k = 81; % intact ribosome

extracted_events = ribosome.extracted_events;
pA_k = extracted_events{k}.event_signal.samples_pA;
selection = (numel(pA_k)-1)/2 + selection_window;
pA_k = pA_k(selection(1):selection(2));
n_k = 1:numel(pA_k);
t_k = n_k./double(extracted_events{k}.event_signal.sampling_rate_Hz);

plot(t_k*1E6,pA_k,'b','Linewidth',1.5);

k = 7; % fragment
extracted_events = ribosome.extracted_events;
pA_k = extracted_events{k}.event_signal.samples_pA;
selection = (numel(pA_k)-1)/2 + selection_window;
pA_k = pA_k(selection(1):selection(2));
n_k = 1:numel(pA_k);
t_k = n_k./double(extracted_events{k}.event_signal.sampling_rate_Hz);

hold on;
plot(t_k*1E6,pA_k,'r','Linewidth',1.5);
set(gca,'ylim',[-2000 500],'xlim',[0 300]);
xlabel('Time (µs)');
ylabel('Ionic Current (pA)');
set(gca,'fontsize',20);


% add baseline
lw = 2;
baseline_y = zeros(1,length(t_k));
plot((t_k*1E6),baseline_y,'--','color',[0.5 0.5 0.5],'linewidth',lw); hold on

legend('intact ribosome (A)','ribosomal fragment (B)','Location','southoutside','Orientation','horizontal');

% Set axes
set(gca,'ylim',[-2000 500],'xlim',[10 300]);