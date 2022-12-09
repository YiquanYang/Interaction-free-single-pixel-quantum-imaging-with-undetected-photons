clc
clear all
close all

Data_raw = importdata('Interference_Nanomotion_IFM.dat');

%% Long Graph
noise = 1400;

size_raw = size( Data_raw );
Displacement_raw = 1*( 0:1:size_raw (1)-1 );
single_count_810 = Data_raw(:,1);
single_count_1550 = Data_raw(:,4)- noise;
coin_counts = Data_raw(:,5);
visibility_810 = ( max( single_count_810 ) - min( single_count_810 ) )/...
    ( max( single_count_810 ) + min( single_count_810 ) )
visibility_1550 = ( max( single_count_1550 ) - min( single_count_1550 ) )/...
    ( max( single_count_1550 ) + min( single_count_1550 ) )
visibility_coin = ( max( coin_counts ) - min( coin_counts ) )/...
    ( max( coin_counts ) + min( coin_counts ) )



figure(1)
plot(Displacement_raw,single_count_810,'o','Markersize',2)
ylabel('810nm Single Counts')
xlabel('Displacement [mm]')
title('Inteference of 810nm Single Photon')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
figure(2)
plot(Displacement_raw,single_count_1550,'o','Markersize',2)
ylabel('1550nm Single Counts')
% xlabel('Displacement [mm]')
xlabel('Times [Seconds]')
% title('Inteference of 1550nm Single Photon')
title('IFM Stability')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
figure(3)
plot(Displacement_raw,coin_counts,'o','Markersize',2)
ylabel('Coincidence Counts')
xlabel('Displacement [mm]')
title('Inteference of Coincidence Counts')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])


%% Cut Graph

num_min = 27;
num_max = 59;

size_raw = size( Data_raw );
Displacement_raw_cut = 0.05*( num_min:1:num_max );
single_count_810_cut = Data_raw(num_min:num_max,1);
single_count_1550_cut = Data_raw(num_min:num_max,4) - noise;
coin_counts_cut = Data_raw(num_min:num_max,5);
visibility_810_cut = ( max( single_count_810_cut ) - min( single_count_810_cut ) )/...
    ( max( single_count_810_cut ) + min( single_count_810_cut ) )
visibility_coinData_cut = ( max( coin_counts_cut ) - min( coin_counts_cut ) )/...
    ( max( coin_counts_cut ) + min( coin_counts_cut ) )

figure(4)
plot(Displacement_raw_cut,single_count_810_cut,'h','Markersize',8)
ylabel('810nm Single Counts')
xlabel('Displacement [\mum]')
title('Inteference of 810nm Single Photon')
set(gca,'Fontsize',18)
set(gcf,'unit','centimeter','position',[10 5 30 10])
xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])
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
set(gca,'Fontname','Times New Roman')
set(gcf,'unit','centimeter','position',[10 5 30 10])
xlim([min(Displacement_raw_cut) max(Displacement_raw_cut)])

var_visibility_1550 = ( sqrt( max(single_count_1550_cut) )+...
    sqrt( min(single_count_1550_cut) ) )/...
    ( max(single_count_1550_cut)+min(single_count_1550_cut) );


% createFit_810(Displacement_raw_cut, single_count_810_cut)

Nano_createFit_1550(Displacement_raw_cut, single_count_1550_cut)

% createFit_CC(Displacement_raw_cut, coin_counts_cut)