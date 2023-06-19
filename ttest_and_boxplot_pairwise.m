
function ttest_and_boxplot_pairwise(varargin)
% ttest_and_boxplot_pairwise - Perform t-test and create a pairwise boxplot

% Example usage:
% ttest_and_boxplot_pairwise(Data1, Data2, 'Tag1', 'Tag2')
% Perform t-test between Data1 and Data2 and create a pairwise boxplot with
% corresponding tags.

n = length(varargin);
n_data = n/2;

% Extract data and tags from input arguments
for i = 1:n_data
    eval(sprintf('Data%d = varargin{%d};',i,i))
    eval(sprintf('Tag%d = varargin{%d};',i,(i+n_data)));
end

% Create group array for boxplot
group = [];
for i = 1:n_data
    group = [group repmat({eval(sprintf('Tag%d',i))}, size(eval(sprintf('Data%d',i))))];
end

% Create Data array for boxplot
Data = [];
for i = 1:n_data
    Data = [Data eval(sprintf('Data%d',i))];
end

% Perform t-tests and create pairwise boxplot
boxplot(Data, group)
ylm_tms = 1.01;
for i = 1:n_data-1
    for j = i+1:n_data
        yt = get(gca, 'YTick');
        axis([xlim    0  ceil(max(yt)*ylm_tms)])
        xt = get(gca, 'XTick');
        hold on
        plot(xt([i j]), [1 1]*max(yt)*ylm_tms, '-k',  mean(xt([i j])), max(yt)*ylm_tms, 'k')
        [tttt,p] = ttest(eval(sprintf('Data%d',i)), eval(sprintf('Data%d',j)));
        
        % Set significance labels based on p-value thresholds
        if p>0.05
            label = 'n.s.';
        elseif p>0.01
            label = '*';
        elseif p>0.001
            label = '**';
        else
            label = '***';
        end
        
        text(mean(xt([i j])), max(yt)*ylm_tms, label)
    end
end

% function ttest_and_boxplot_pairwise(varargin)
% n = length(varargin);
% n_data = n/2;
% for i = 1:n_data
%     eval(sprintf('Data%d = varargin{%d};',i,i))
%     eval(sprintf('Tag%d = varargin{%d};',i,(i+n_data)));
% end
% % Data1, Data2, Tag1, Tag2
% s0 = [];
% s = sprintf('group = [');
% s0 = [s0 s];
% for  i = 1:n_data
%       
%     if i<n_data
%         s = sprintf('repmat({Tag%d},size(Data%d));',i,i);
%         s0 = [s0 s];
%     else
%         s = sprintf('repmat({Tag%d},size(Data%d))];',i,i);
%         s0 = [s0 s];
%     end
% end
% eval(s0)
% 
% 
% s0 = [];
% s = sprintf('Data = [');
% s0 = [s0 s];
% for  i = 1:n_data
%       
%     if i<n_data
%         s = sprintf('Data%d;',i);
%         s0 = [s0 s];
%     else
%         s = sprintf('Data%d];',i);
%         s0 = [s0 s];
%     end
% end
% eval(s0)
% 
% 
% % group = [...
% %     repmat({Tag1},size(Data1))...
% %     ;...
% %     repmat({Tag2},size(Data2))...
% %     ];
% % Data = [...
% %     Data1;...
% %     Data2];
% 
% boxplot(Data,group)
% ylm_tms = 1.01;
% for  i = 1:n_data-1
% 
%     for j = i+1:n_data
%         yt = get(gca, 'YTick');
%         axis([xlim    0  ceil(max(yt)*ylm_tms)])
%         xt = get(gca, 'XTick');
%         hold on
%         plot(xt([i j]), [1 1]*max(yt)*ylm_tms, '-k',  mean(xt([i j])), max(yt)*ylm_tms, 'k')
%         %         [tttt,p] = ttest(Data1,Data2);
%         eval(sprintf('[tttt,p] = ttest(Data%d,Data%d);',i,j))
%         % threhsold is from
%         % https://www.graphpad.com/support/faq/what-is-the-meaning-of--or--or--in-reports-of-statistical-significance-from-prism-or-instat/
%         % Might be slightly ramdom?
%         if p>0.05
%             label = 'n.s.';
%         elseif p>0.01
%             label = '*';
%         else
%             if p>0.001
%                 label = '**';
%             else
%                 label = '***';
%             end
%         end
%         text( mean(xt([i j])), max(yt)*ylm_tms, label)
% %         hold off
% 
%     end
% end
% 
% 
