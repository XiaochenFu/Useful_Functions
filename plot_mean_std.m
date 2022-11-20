    function h = plot_mean_std(x,y,std_dev,c)
        curve1 = y' + std_dev';
        curve2 = y' - std_dev';
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        fill(x2, inBetween,c, 'FaceAlpha', 0.2,'HandleVisibility','off');
        hold on
        h = plot(x, y,'color',c);
    end