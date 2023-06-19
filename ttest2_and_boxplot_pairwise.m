function ttest2_and_boxplot_pairwise(varargin)
n = length(varargin);
n_data = n/2;
for i = 1:n_data
    eval(sprintf('Data%d = varargin{%d};',i,i))
    eval(sprintf('Tag%d = varargin{%d};',i,(i+n_data)));
end
% Data1, Data2, Tag1, Tag2
s0 = [];
s = sprintf('group = [');
s0 = [s0 s];
for  i = 1:n_data
    if i<n_data
        s = sprintf('repmat({Tag%d},size(Data%d));',i,i);
        s0 = [s0 s];
    else
        s = sprintf('repmat({Tag%d},size(Data%d))];',i,i);
        s0 = [s0 s];
    end
end
eval(s0)


s0 = [];
s = sprintf('Data = [');
s0 = [s0 s];
for  i = 1:n_data
    if i<n_data
        s = sprintf('Data%d;',i);
        s0 = [s0 s];
    else
        s = sprintf('Data%d];',i);
        s0 = [s0 s];
    end
end
eval(s0)


% group = [...
%     repmat({Tag1},size(Data1))...
%     ;...
%     repmat({Tag2},size(Data2))...
%     ];
% Data = [...
%     Data1;...
%     Data2];


%% add original data
s0 = [];
s = sprintf('lbs = [');
s0 = [s0 s];
for  i = 1:n_data
    if i<n_data
        s = sprintf('repmat(%d,size(Data%d));',i,i);
        s0 = [s0 s];
    else
        s = sprintf('repmat(%d,size(Data%d))];',i,i);
        s0 = [s0 s];
    end
end
eval(s0)
hold on 
plot(lbs,Data,'k.');
%% Add boxplot
hold on
boxplot(Data,group)
%% Add comperation
ylm_tms = 1.2;
yt = get(gca, 'YTick');
y_position = max(Data)*ylm_tms;
for  i = 1:n_data-1

    for j = i+1:n_data

        %         axis([xlim    min(yt)  ceil(max(yt)*ylm_tms)])
        xt = get(gca, 'XTick');
        hold on
        plot(xt([i j]).*[1.1 0.9], [1 1]*y_position, '-k')
        y_position = y_position*ylm_tms;
        %         plot(xt([i j]), [1 1]*max(yt)*ylm_tms, '-k',  mean(xt([i j])), max(yt)*ylm_tms, 'k')
        %         [tttt,p] = ttest2(Data1,Data2);
        eval(sprintf('[tttt,p] = ttest2(Data%d,Data%d);',i,j))
        % threhsold is from
        % https://www.graphpad.com/support/faq/what-is-the-meaning-of--or--or--in-reports-of-statistical-significance-from-prism-or-instat/
        % Might be slightly ramdom?
        if p>0.05
            label = 'n.s.';
        elseif p>0.01
            label = '*';
        else
            if p>0.001
                label = '**';
            else
                label = '***';
            end
        end
        %         text( mean(xt([i j])), max(yt)*ylm_tms, label)
        text( mean(xt([i j]).*[1.1 0.9]), y_position*0.91, label)
        %         hold off

    end
end


