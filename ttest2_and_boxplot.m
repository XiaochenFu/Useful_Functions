function ttest2_and_boxplot(Data1, Data2, Tag1, Tag2)

group = [repmat({Tag1},size(Data1));
         repmat({Tag2},size(Data2))];

boxplot([Data1; Data2],group)


yt = get(gca, 'YTick');
axis([xlim    0  ceil(max(yt)*1.4)])
xt = get(gca, 'XTick');
hold on
plot(xt([1 2]), [1 1]*max(yt)*1.1, '-k',  mean(xt([1 2])), max(yt)*0.9, 'k')
[tttt,p] = ttest2(Data1,Data2);
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
text(1.5, max(yt)*1.25, label)
hold off
