%% Raw

clear
close all



% Image data import knife test
Image_raw = importdata('31.asc');


% Noise data import
Noise = importdata('background.asc');


% NJU data axis setup
% Size_raw = size( Image_raw_Top );

% x_value = linspace(1,Size_raw(1),Size_raw(1));
% y_value = linspace(1,Size_raw(2),Size_raw(2));
% 
% [X_value,Y_value] = meshgrid(y_value, x_value);

% Knife Image data axis setup
Size_raw = size( Image_raw );

x_value = linspace(1,Size_raw(1),Size_raw(1));
y_value = linspace(1,Size_raw(2),Size_raw(2));

[X_value,Y_value] = meshgrid(y_value, x_value);

%% Square cut
% mesh(X,Y,Z)函数，X 和 Y 分别对应于 Z 的列和行


% Knife Image Cut

pixel_cut_number = 50;
x_cut_left = 113;
x_cut_right = pixel_cut_number+ x_cut_left;
y_cut_left = 90;
y_cut_right = y_cut_left+ pixel_cut_number;

% N cut
% pixel_cut_number = 90;
% x_cut_left = 70;
% x_cut_right = pixel_cut_number+ x_cut_left;
% y_cut_left = 85;
% y_cut_right = y_cut_left+ pixel_cut_number;

% J cut
% pixel_cut_number = 75;
% x_cut_left = 80;
% x_cut_right = pixel_cut_number+ x_cut_left;
% y_cut_left = 94;
% y_cut_right = y_cut_left+ pixel_cut_number;



% NJU image manipulation
% Image_cut_Top = Image_raw_Top( x_cut_left:x_cut_right, y_cut_left:...
%    y_cut_right);
% Image_cut_Dip = Image_raw_Dip( x_cut_left:x_cut_right, y_cut_left:...
%    y_cut_right);
% Image_cut_diff = Image_cut_Top - Image_cut_Dip;
% Image_cut_max = max(max( Image_cut_diff ));
% Image_cut_norm = ( Image_cut_diff/Image_cut_max )*1500;



% Image data cut
Image_raw_cut = Image_raw ( x_cut_left:x_cut_right, y_cut_left:y_cut_right);


% Noise data cut
Noise_cut = Noise( x_cut_left:x_cut_right, y_cut_left:y_cut_right);

% Noise subtraction
Image_raw_cut_denoise = Image_raw_cut - Noise_cut;


x_value_cut = linspace(1,pixel_cut_number+1,pixel_cut_number+1)*13.3;
y_value_cut = linspace(1,pixel_cut_number+1,pixel_cut_number+1)*13.3;

% x_value_cut = linspace(1,pixel_cut_number+1,pixel_cut_number+1);
% y_value_cut = linspace(1,pixel_cut_number+1,pixel_cut_number+1);



[X_value_cut,Y_value_cut] = meshgrid(x_value_cut, y_value_cut);



color_axis_min = 900;
color_axis_max = 2000;

%% Raw Image

figure(1)
mesh(X_value, Y_value, Image_raw);
view(0, 90);
axis tight
set(gca,'Fontname', 'Arial','FontSize',18)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
% colorbar
set(gca,'tickdir','out')
set(gcf,'position',[200,200,500,400]);  
%set(gcf,'position',[centerX,centerY,width,height])
caxis([color_axis_min,color_axis_max]);


%% Cut Image

figure(2)
surf(X_value_cut, Y_value_cut, Image_raw_cut_denoise);
view(0, 90);
% view(90, 90);

axis tight
shading interp; 
set(gca,'Fontname', 'Times New Roman','FontSize',22)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
% colorbar
set(gca,'xtick',(0:200:600));
set(gca,'ytick',(0:200:600));
% xlabel('\mum')
% ylabel('\mum')
set(gca,'tickdir','out')
set(gcf,'unit','centimeter','position',[10 5 15 12])

% title('Knife Test Image')
 
%set(gcf,'position',[centerX,centerY,width,height])
caxis([color_axis_min,color_axis_max+200]);
colorbar
saveas(gcf,'slice.png')

% annotation('rectangle',[0.42 0.53 0.18 0.22],'Color',[1 0 0],...
%     'LineWidth',2,...
%     'LineStyle','--')


%% Slice 
% 横轴y,竖轴x

% knife slice along X

pixel_cut_number_cut =pixel_cut_number;


x_cut_left = 1;
x_cut_right = pixel_cut_number_cut+ x_cut_left;
y_cut_left = 15;
% y_cut_left value is less than one half of pixel_cut_number

y_cut_right = pixel_cut_number_cut-y_cut_left;


Image_dip_cut = Image_raw_cut_denoise( x_cut_left:x_cut_right, y_cut_left:...
   y_cut_right);
Image_dip_sum = sum( Image_dip_cut,2 )/( pixel_cut_number_cut-2*y_cut_left );

% diff_counts = abs( diff(Image_dip_sum) );
x_value_diff = x_value(1:50)*13.3;

y_axis_min = min(Image_dip_sum)-100;
y_axis_max = max(Image_dip_sum)+100;


Image_dip_sum_cut = Image_dip_sum(30:45);
Image_dip_sum_cut_norm = Image_dip_sum(30:45)/max( Image_dip_sum_cut );


% x_value = linspace(1,pixel_cut_number_cut+1,pixel_cut_number_cut+1)*13.3;
x_value = 13.3* linspace(1,pixel_cut_number_cut+1,pixel_cut_number_cut+1);

figure(3)
plot(x_value,Image_dip_sum,'+','Markersize',12)
xlabel('Position（\mu m)')
ylabel('Counts/sec')
set(gca,'Fontsize',18)
% axis([0 (pixel_cut_number_cut+1) y_axis_min y_axis_max]);
axis([min( x_value ) max( x_value ) y_axis_min y_axis_max]);

set(gcf,'unit','centimeter','position',[10 5 20 12])

%% fit

knife_fit(x_value, Image_dip_sum)
