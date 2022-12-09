clear
close all
Data_with_object = importdata('IFM_With_object.dat');
Data_without_object = importdata('IFM_Without_object.dat');




%% Histogram Display

single_count_810_cut_1 = zeros(998,1);

single_count_810_cut_1 = Data_without_object(2:999,1);

single_count_810_cut_2 = zeros(998,1);

single_count_810_cut_2 = Data_with_object(2:999,1);


count_810_without_object = single_count_810_cut_1;
count_810_with_object = single_count_810_cut_2;


x_min = 2.6*1e3;
x_max = 3.8*1e3;



bin = 20;


h_without_object = histogram(count_810_without_object,'Binwidth',bin);


L_without_object = length(h_without_object.BinEdges);
for i = 1:L_without_object -1
    x_without_object (i)= ( h_without_object.BinEdges(i) + h_without_object.BinEdges(i+1) )/2;
end
y_without_object = h_without_object.Values;


h_with_object = histogram(count_810_with_object,'Binwidth',bin);
L_with_object = length(h_with_object.BinEdges);
for i = 1:L_with_object -1
    x_with_object (i)= ( h_with_object.BinEdges(i) + h_with_object.BinEdges(i+1) )/2;
end
y_with_object = h_with_object.Values;



counts_mean_1 = 2942;
counts_mean_2 = 3517;

var_1 = 135.2;
var_2 = 104.6;

counts = x_min : 5 : x_max;


sigma_1 = var_1/sqrt(2);
sigma_2 = var_2/sqrt(2);

gaussian_1 = 84.93*exp(-(counts-counts_mean_1).^2./(var_1^2));
gaussian_2 = 108.5*exp(-(counts-counts_mean_2).^2./(var_2^2));


y_min = 0;
y_max = 150;
x_threshold = counts_mean_1 + 3.4*sigma_1;



figure(1)
% histogram(count_810_without_object,'Binwidth',bin,'FaceAlpha',0.2)
histogram(count_810_without_object,'Binwidth',bin)
hold on
histogram(count_810_with_object,'Binwidth',bin)
hold on
plot(counts,gaussian_1,'b','LineWidth',3)
hold on
plot(counts,gaussian_2,'m','LineWidth',3)
hold on
plot([x_threshold, x_threshold], [0 y_max],'k--','LineWidth',2)

text(x_threshold,140,'\leftarrow threshold','FontSize',22,'FontName','Times New Roman')

ylabel('Occurrences')
xlabel('Counts/sec')
% title('Interaction-free Quantum Sensing with Undetected Photons')
% legend( 'Without Object','With Object', 'Gaussian Fitting',...
%     'Gaussian Fitting','Location', 'NorthWest' );
legend( 'Without Object','With Object','Location', 'NorthWest' );
legend('boxoff');
xlim([x_min  x_max])
ylim([y_min y_max])

set(gca,'FontName','Times New Roman')
set(gca,'linewidth',3)
set(gca,'Fontsize',22)
set(gcf,'unit','centimeter','position',[10 5 20 12])
