function [event,stats] = detect_event(pA,thresh,verbose)
    % Default to suppressing plot
    if nargin<3, verbose = false; end
    % Default to 6-sigma below baseline
    if nargin<2, thresh = 6; end
    
    % Non-user specified options
    N_bins = 50;
    
    % Model signal using mixture of Gaussians
    f = fitgmdist(pA',3);

    % Find baseline as max of means (assumes event lowers current) 
    id = find(f.mu==max(f.mu));
    
    % Calculate threshold current for an event
    pA_thresh = f.mu(id)-thresh*sqrt(f.Sigma(id));
    
    % Calculate binary vector
    b_pA = pA<pA_thresh;
    
    % Find indices
    id_pA = find(b_pA);
    
    if verbose
        figure('color',[1 1 1]);
        histogram(pA,N_bins,'Normalization','pdf')
        xgrid = [floor(min(pA)):ceil(max(pA))]';
        hold on; plot(xgrid,pdf(f,xgrid),'r-'); hold off
        n1 = makedist('normal',f.mu(1),sqrt(f.Sigma(1)));
        n2 = makedist('normal',f.mu(2),sqrt(f.Sigma(2)));
        n3 = makedist('normal',f.mu(3),sqrt(f.Sigma(3)));
        p = f.ComponentProportion;
        y = p(1)*pdf(n1,xgrid) + p(2)*pdf(n2,xgrid) + p(3)*pdf(n3,xgrid);
        hold on; plot(xgrid,y,'c--'); hold off
        hold on; plot(pA_thresh*[1 1],get(gca,'ylim'),'-k'); hold off;
        xlabel('Current (pA)');
        ylabel('Number of Samples');
    end
    
    % Return results
    
    % Start and End of event
    event(1) = id_pA(1);
    event(2) = id_pA(end);
    
    % Stats
    stats.mean_amp_pA = mean(pA(b_pA));
    stats.std_amp_pA = std(pA(b_pA));
    stats.mean_base_pA = mean(pA(~b_pA));
    stats.std_base_pA = std(pA(~b_pA));
    stats.binary = b_pA;
end
