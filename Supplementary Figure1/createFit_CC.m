function [fitresult, gof] = createFit_CC(Displacement_raw_cut, coin_counts_cut)
%CREATEFIT5(DISPLACEMENT_RAW_CUT,COIN_COUNTS_CUT)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : Displacement_raw_cut
%      Y Output: coin_counts_cut
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 12-Jul-2020 22:22:10 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( Displacement_raw_cut, coin_counts_cut );

% Set up fittype and options.
ft = fittype( 'fourier1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 3.92699081698767];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

xneg = 2* coin_counts_cut.^(1/2);
xpos = 2* coin_counts_cut.^(1/2);



% Plot fit with data.
figure1 = figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, 'k');
h.LineWidth = 4;
set(gca,'linewidth',3)
hold on 
h = errorbar(Displacement_raw_cut,coin_counts_cut,xneg,xpos,'r.','Markersize',16,'linewidth',2);


% legend( 'Fitting Curve','Raw Data', 'Location', 'SouthEast' );
legend( 'Fitting Curve','Raw Data');
legend('boxoff');
legend('Location',[0.57 0.2 0.272 0.152]);



% Label axes
xticks([0 0.775 1.55 2.325 3.1])
xticklabels({'0','\pi','2\pi','3\pi','4\pi'})

ylabel('Coincidence rates (counts/sec)')
xlabel('Phase (\theta)')

% xlabel('Position (\mum)')
% title('Interference of Coincidence Counts')
set(gca,'Fontsize',22)
set(gca,'Fontname','Times New Roman')
set(gcf,'unit','centimeter','position',[10 5 20 13])
xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])

ylim([0 max( coin_counts_cut )+( max( coin_counts_cut )- min( coin_counts_cut ) )*0.3])

visibility_CC_cut = ( max( coin_counts_cut ) - min( coin_counts_cut ) )/...
    ( max( coin_counts_cut ) + min( coin_counts_cut ) );
var_visibility_CC = ( sqrt( max(coin_counts_cut) )+...
    sqrt( min(coin_counts_cut) ) )/...
    ( max(coin_counts_cut)+min(coin_counts_cut) );

str_vis = strjoin({'Visibility =',num2str(visibility_CC_cut*100,'%.1f'),'\pm',...
    num2str(var_visibility_CC*100,'%.1f'),'%'});



% % Test in Supplementary Fig.1 
dim = [0.2 0.4 0.5 0.08];
annotation('textbox',dim,...
    'String',str_vis,...
    'LineWidth',2,...
    'HorizontalAlignment','center',...
     'FontSize',22,'linestyle','none','FontName','Times New Roman');

ax1 = gca;
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'Color','none', 'YTick',zeros(1,0));
% xlabel(ax2,'x1 label name');
set(ax2,'xlim',[min(Displacement_raw_cut) max(Displacement_raw_cut)])
set(ax2,'XTick',[0 0.775 1.55 2.325 3.1],'XTickLabel',{'0','0.775','1.55','2.325','3.1'})
set(ax2,'Fontsize',22)
set(ax2,'Fontname','Times New Roman')

% annotation(figure1,'textbox',...
%     [0.9 0.9 0.05 0.122],...
%     'String','(\mum)',...
%     'FitBoxToText','off','Fontsize',22,'linestyle','none')


grid off


saveas(gcf,'CC','tiff')


