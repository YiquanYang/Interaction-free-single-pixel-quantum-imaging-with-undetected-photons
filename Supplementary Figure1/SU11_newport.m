clear;
close all;



% Data_raw = importdata('Interference_Newport_SU11_Without1.dat');
% Data_raw = importdata('Interference_Newport_SU11_With.dat');

% Data_raw = importdata('Interference_Newport_Top.dat');
Data_raw = importdata('Interference_Newport_dip.dat');



Data_raw(:,2) = Data_raw(:,2);
Data_raw(:,5) = Data_raw(:,5);
Data_raw(:,6) = Data_raw(:,6);



%% Long Graph


size_raw = size( Data_raw );
Displacement_raw = 0:1:size_raw (1)-1 ;
% Displacement_raw = 17:0.01:17+0.01*(size_raw-1);

single_count_810 = Data_raw(:,2);
single_count_1550 = Data_raw(:,5);
coin_counts = Data_raw(:,6);
visibility_810 = ( max( single_count_810 ) - min( single_count_810 ) )/...
    ( max( single_count_810 ) + min( single_count_810 ) );
visibility_1550 = ( max( single_count_1550 ) - min( single_count_1550 ) )/...
    ( max( single_count_1550 ) + min( single_count_1550 ) );

visibility_coin = ( max( coin_counts ) - min( coin_counts ) )/...
    ( max( coin_counts ) + min( coin_counts ) );



figure(1)
plot(Displacement_raw,single_count_810,'r.','Markersize',12);


xneg =  2*single_count_810.^(1/2);
xpos =  2*single_count_810.^(1/2);
h = errorbar(Displacement_raw,single_count_810,xneg,xpos,'.','Markersize',12);

str_vis = strjoin({'Visibility=',num2str(visibility_810*100,3),'%'});

dim = [0.15 0.2 0.2 0.08];
annotation('textbox',dim,...
    'String',str_vis,...
    'LineWidth',2,...
    'HorizontalAlignment','center',...
    'FontSize',18);


title('Inteference of 810nm Single Photon')
% title('Stability Test of Signal Photons Counting Without Interference')
% set(gca,'linewidth',2)

ylabel('Single Counts (Hz)')
xlabel('Time [Second]')

set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 12])

% dim = [0.2 0.4 0.3 0.08];
% annotation('textbox',dim,...
%     'String','Visibility = 10.55\pm 0.59%',...
%     'LineWidth',2,...
%     'HorizontalAlignment','center',...
%     'FontSize',14);
xlim([min(Displacement_raw) max(Displacement_raw)])

ylim([0 max(single_count_810)+2000])




figure(2)
plot(Displacement_raw,single_count_1550,'o','Markersize',2)
xneg =  5*single_count_1550.^(1/2);
xpos =  5*single_count_1550.^(1/2);
h = errorbar(Displacement_raw,single_count_1550,xneg,xpos,'.','Markersize',12);

ylabel('1550nm Single Counts')
xlabel('Displacement [mm]')
title('Inteference of 1550nm Single Photon')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 12])
xlim([min(Displacement_raw) max(Displacement_raw)])


figure(3)
plot(Displacement_raw,coin_counts,'o','Markersize',2)
% envelope(coin_counts,20,'peak')
xneg =  5*coin_counts.^(1/2);
xpos =  5*coin_counts.^(1/2);
h = errorbar(Displacement_raw,coin_counts,xneg,xpos,'.','Markersize',12);

ylabel('Coincidence Counts')
xlabel('Displacement [mm]')
title('Inteference of Coincidence Counts')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
xlim([min(Displacement_raw) max(Displacement_raw)])

% hold on

% [up,lo] = envelope(coin_counts,300);
% plot(Displacement_raw,up,Displacement_raw,lo,'linewidth',1.5)

%% Cut Graph
% sample 33 points @ with object in Fig.2
% num_min = 37;
% num_max = 70;
% num_diff = num_max-num_min;

% % sample 33 points @ without object in Fig.2
% num_min = 40;
% num_max = 73;
% num_diff = num_max-num_min;


% % sample 33 points @ constructive point in Supplementary Fig.2
% num_min = 29;
% num_max = 62;
% num_diff = num_max-num_min;

% sample 33 points @ destructive point in Supplementary Fig.2
num_min = 55;
num_max = 88;
num_diff = num_max-num_min;

Displacement_raw_cut = 2*1000* ( Data_raw(num_min:num_max,1)-min(Data_raw(num_min:num_max,1)) );
single_count_810_cut = Data_raw(num_min:num_max,2);
single_count_1550_cut = Data_raw(num_min:num_max,5);
coin_counts_cut = Data_raw(num_min:num_max,6);
visibility_810_cut = ( max( single_count_810_cut ) - min( single_count_810_cut ) )/...
    ( max( single_count_810_cut ) + min( single_count_810_cut ) );
visibility_1550_cut = ( max( single_count_1550_cut ) - min( single_count_1550_cut ) )/...
    ( max( single_count_1550_cut ) + min( single_count_1550_cut ) );
visibility_coin_cut = ( max( coin_counts_cut ) - min( coin_counts_cut ) )/...
    ( max( coin_counts_cut ) + min( coin_counts_cut ) );


counts_810_avergage = mean(single_count_810_cut);
average_810 = ones(num_max-num_min+1,1)*counts_810_avergage;

figure(4)
plot(Displacement_raw_cut,single_count_810_cut,'h','Markersize',8)
ylabel('810nm Single Counts')
xlabel('Displacement [\mum]')
title('Inteference of 810nm Single Photon')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])
% ylim([0 40000])

figure(5)
plot(Displacement_raw_cut,single_count_1550_cut,'h','Markersize',8)
ylabel('1550nm Single Counts')
xlabel('Displacement [\mum]')
title('Inteference of 1550nm Single Photon')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])
figure(6)
plot(Displacement_raw_cut,coin_counts_cut,'h','Markersize',8)
ylabel('Coincidence Counts')
xlabel('Displacement [\mum]')
title('Inteference of Coincidence Counts')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])

var_visibility_810 = ( sqrt( max(single_count_810_cut) )+...
    sqrt( min(single_count_810_cut) ) )/...
    ( max(single_count_810_cut)+min(single_count_810_cut) );
var_visibility_1550 = ( sqrt( max(single_count_1550_cut) )+...
    sqrt( min(single_count_1550_cut) ) )/...
    ( max(single_count_1550_cut)+min(single_count_1550_cut) );
var_visibility_CC = ( sqrt( max(coin_counts_cut) )+...
    sqrt( min(coin_counts_cut) ) )/...
    ( max(coin_counts_cut)+min(coin_counts_cut) );

%% fit

createFit_810(Displacement_raw_cut, single_count_810_cut)

createFit_1550(Displacement_raw_cut, single_count_1550_cut)

createFit_CC(Displacement_raw_cut, coin_counts_cut)