function [fitresult, gof] = createFit_810(Displacement_raw_cut, single_count_810_cut)


[xData, yData] = prepareCurveData( Displacement_raw_cut, single_count_810_cut );




% Set up fittype and options.
ft = fittype( 'fourier1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 3.92699081698767];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

%% Figure 2
% xneg =  2*single_count_810_cut.^(1/2);
% xpos =  2*single_count_810_cut.^(1/2);

%% Figure S1
xneg =  5*single_count_810_cut.^(1/2);
xpos =  5*single_count_810_cut.^(1/2);

% Plot fit with data.
figure1 = figure( 'Name', 'untitled fit 1' );

% 创建 axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');

h = plot( fitresult,'k');
h.LineWidth = 4;
set(gca,'linewidth',3)
hold on 
h = errorbar(Displacement_raw_cut,single_count_810_cut,xneg,xpos,'r.','Markersize',16,'linewidth',2);
% Label axes

hold on 


%% Figure S1

legend( 'Fitting Curve','Raw Data', 'Location', 'SouthEast');
legend( 'Fitting Curve','Raw Data');
legend('boxoff');
legend('Location',[0.57 0.2 0.272 0.152]);
xticks([0 0.775 1.55 2.325 3.1])
xticklabels({'0','\pi','2\pi','3\pi','4\pi'})

%% Figure 2 for "with object" in IFM
% max_810 = ones(34,1)*3523;
% plot(Displacement_raw_cut, max_810,'m--','linewidth',2 )
% legend( 'Fitting Curve','Raw Data','Maximum Line', 'Location', 'SouthEast' );
% legend('boxoff')
% xticks([0 0.775 1.55 2.325 3.1])
% xticklabels({'0','\pi','2\pi','3\pi','4\pi'})

%% Figure 2 for "without object" in IFM

% average_810 = ones(34,1)*2950;
% plot(Displacement_raw_cut, average_810,'b--','linewidth',2 )
% legend( 'Fitting Curve','Raw Data','Average Line', 'Location', 'SouthEast');
% legend('boxoff')
% 
% xticks([0 0.775 1.55 2.325 3.1])
% xticklabels({'0','\pi','2\pi','3\pi','4\pi'})


%% Axes setup for Supplementary Fig 1 
yticks([0 1e4 2e4 3e4 4e4 5e4])
yticklabels({'0','10^4','2\times10^4','3\times10^4','4\times10^4','5\times10^4'})

ylabel('Single rates (counts/sec)')
xlabel('Phase (\theta)')


set(gca,'Fontsize',22)
set(gca, 'FontName','Times New Roman')

set(gcf,'unit','centimeter','position',[10 5 20 13])

xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])


% ylim([min(single_count_810_cut)-1000 max(single_count_810_cut)+2000])  
% ylim([0 max(single_count_810_cut)+200])
ylim([0 max( single_count_810_cut )+(max( single_count_810_cut )- min(single_count_810_cut ))*0.3]) 


%% Axes setup For Figure 2 


% set(gca,'Fontsize',22)
% set(gcf,'unit','centimeter','position',[5 10 20 13])
% 
% xlabel('Phase (\theta)')
% ylabel('Single rates (counts/sec)')
% 
% set(gca,'FontName','Times New Roman')
% 
% xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])
% ylim([0 4200])  

% ylim([0 3000])

%% Visibility caption For Figure 2 and S1


visibility_810_cut = ( max( single_count_810_cut ) - min( single_count_810_cut ) )/...
    ( max( single_count_810_cut ) + min( single_count_810_cut ) );
var_visibility_810 = ( sqrt( max(single_count_810_cut) )+...
    sqrt( min(single_count_810_cut) ) )/...
    ( max(single_count_810_cut)+min(single_count_810_cut) );

str_vis = strjoin({'Visibility =',num2str(visibility_810_cut*100,'%.1f'),'\pm',...
    num2str(var_visibility_810*100,'%.1f'),'%'});


% % Fig.2 
% dim = [0.15 0.3 0.5 0.08];
% annotation('textbox',dim,...
%     'String',str_vis,...
%     'LineWidth',2,...
%     'HorizontalAlignment','center',...
%     'FontSize',22,'linestyle','none','FontName','Times New Roman');

% % Fig.S1 
dim = [0.2 0.4 0.5 0.08];
annotation('textbox',dim,...
    'String',str_vis,...
    'LineWidth',2,...
    'HorizontalAlignment','center',...
    'FontSize',22,'linestyle','none','Fontname','Times New Roman');

%% double x-axis

ax1 = gca;
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'Color','none', 'YTick',zeros(1,0));
% xlabel(ax2,'x1 label name');
set(ax2,'xlim',[min(Displacement_raw_cut) max(Displacement_raw_cut)])
set(ax2,'XTick',[0 0.775 1.55 2.325 3.1],'XTickLabel',{'0','0.775','1.55','2.325','3.1'},'FontName','Times New Roman')
set(ax2,'Fontsize',22)
% xlabel(ax2,'Mirror position (\mum)')

% annotation(figure1,'textbox',...
%     [0.9 0.9 0.05 0.122],...
%     'String','(\mum)',...
%     'FitBoxToText','off','Fontsize',22,'linestyle','none')

grid off

saveas(gcf,'Counts_810','tiff')


