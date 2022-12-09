clear
close all;

% Data import

color_min = 0;
color_max =3000;

Image_raw_N_Top = importdata('N1T10.asc');
Image_raw_J_Top = importdata('J1T7.asc');
Image_raw_U_Top = importdata('U1T18.asc');


% Image_raw_N_Top = importdata('N1D11.asc');
% Image_raw_J_Top = importdata('J1D2.asc');
% Image_raw_U_Top = importdata('U1D40.asc');


Image_raw_N_Dip = importdata('N1D22.asc');
Image_raw_J_Dip = importdata('J1D2.asc');
Image_raw_U_Dip = importdata('U1D40.asc');


% Image_raw_N_Dip = importdata('background1.asc');
% Image_raw_J_Dip = importdata('background1.asc');
% Image_raw_U_Dip = importdata('background1.asc');
% 


Image_raw_N_Diff = Image_raw_N_Top - Image_raw_N_Dip;
Image_raw_J_Diff = Image_raw_J_Top - Image_raw_J_Dip;
Image_raw_U_Diff = Image_raw_U_Top - Image_raw_U_Dip;

% Image_raw_N_max = max(max( Image_raw_N_diff ));
% Image_raw_J_max = max(max( Image_raw_J_diff ));
% Image_raw_U_max = max(max( Image_raw_U_diff ));
% 
% Image_raw_N = 1500*Image_raw_N_diff/Image_raw_N_max;
% Image_raw_J = 1400*Image_raw_J_diff/Image_raw_J_max;
% Image_raw_U = 1300*Image_raw_U_diff/Image_raw_U_max;
 


%% NJU cut


x_axis = (256)*3+20;
y_axis = 257;

% 绘制Top NJU

Image_NJU_Top( 1:256,1:257 ) = Image_raw_N_Top*0.8;
Image_NJU_Top( (256+1+10):(256*2+10),1:257) = Image_raw_J_Top;
Image_NJU_Top( (256*2+1+20):(256*3+20),1:257 ) = Image_raw_U_Top;


% 绘制Dip NJU

Image_NJU_Dip( 1:256,1:257 ) = Image_raw_N_Dip;
Image_NJU_Dip( (256+1+10):(256*2+10),1:257) = Image_raw_J_Dip;
Image_NJU_Dip( (256*2+1+20):(256*3+20),1:257 ) = Image_raw_U_Dip;

% 绘制Dip NJU

Image_NJU_Diff( 1:256,1:257 ) = Image_raw_N_Diff;
Image_NJU_Diff( (256+1+10):(256*2+10),1:257) = Image_raw_J_Diff;
Image_NJU_Diff( (256*2+1+20):(256*3+20),1:257 ) = Image_raw_U_Diff;


% Image_NJU(:,1:81) = fliplr( flipud( (Image_raw_U_Cut) ) );




x_value = linspace(1,y_axis,y_axis);
y_value = linspace(1,x_axis,x_axis);

[X_value,Y_value] = meshgrid(x_value, y_value);


figure(1)

surf(X_value, Y_value, Image_NJU_Top);

% surf(X_value_cut, Y_value_cut, -Image_NJU + rand(390, 100)*200+1000);

view(90,90);

% view(0, 90);
axis tight
shading interp; 
set(gca,'Fontname', 'Arial','FontSize',18)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
colorbar
% set(gca,'xtick',(0:200:1000));
% set(gca,'ytick',(0:200:1000));
xlabel('Pixels')
ylabel('Pixels')   
set(gca,'tickdir','out')
set(gcf,'unit','centimeter','position',[10 5 30 12])
% set(gcf,'position',[centerX,centerY,width,height])
caxis([color_min,color_max]);

saveas(gcf,'NJU_1.png');

% save afile.dat -ascii Image_raw_N_Top

figure(2)

surf(X_value, Y_value, Image_NJU_Dip);

% surf(X_value_cut, Y_value_cut, -Image_NJU + rand(390, 100)*200+1000);

view(90,90);

% view(0, 90);
axis tight
shading interp; 
set(gca,'Fontname', 'Arial','FontSize',18)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
colorbar
% set(gca,'xtick',(0:200:1000));
% set(gca,'ytick',(0:200:1000));
xlabel('Pixels')
ylabel('Pixels')   
set(gca,'tickdir','out')
set(gcf,'unit','centimeter','position',[10 5 30 12])
% set(gcf,'position',[centerX,centerY,width,height])
caxis([color_min,color_max]);

saveas(gcf,'NJU_1.png');

% save afile.dat -ascii Image_raw_N_Top


color_min = 0;
color_max =1800;


figure(3)

surf(X_value, Y_value, Image_NJU_Diff);

% surf(X_value_cut, Y_value_cut, -Image_NJU + rand(390, 100)*200+1000);

view(90,90);

% view(0, 90);
axis tight
shading interp; 
set(gca,'Fontname', 'Arial','FontSize',18)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
colorbar
% set(gca,'xtick',(0:200:1000));
% set(gca,'ytick',(0:200:1000));
xlabel('Pixels')
ylabel('Pixels')   
set(gca,'tickdir','out')
set(gcf,'unit','centimeter','position',[10 5 30 12])
% set(gcf,'position',[centerX,centerY,width,height])
caxis([color_min,color_max]);

saveas(gcf,'NJU_1.png');

% save afile.dat -ascii Image_raw_N_Top

%% NJU cut

pixel_cut_number = 70;
% N cut
x_cut_left_N = 80;
x_cut_right_N = pixel_cut_number+ x_cut_left_N;
y_cut_left_N = 94;
y_cut_right_N = y_cut_left_N+ pixel_cut_number;

% J cut
x_cut_left_J = 89;
x_cut_right_J = pixel_cut_number+ x_cut_left_J;
y_cut_left_J = 97;
y_cut_right_J = y_cut_left_J+ pixel_cut_number;

% U cut
x_cut_left_U = 82;
x_cut_right_U = pixel_cut_number+ x_cut_left_U;
y_cut_left_U = 95;
y_cut_right_U = y_cut_left_U+ pixel_cut_number;


x_axis = (pixel_cut_number+1)*3+20;
y_axis = pixel_cut_number +1;


% 绘制Diff NJU 

Image_NJU = ones(233, 71)*color_max;  

Image_raw_N_Cut = Image_raw_N_Diff( x_cut_left_N:x_cut_right_N, y_cut_left_N:...
   y_cut_right_N);
Image_raw_J_Cut = Image_raw_J_Diff( x_cut_left_J:x_cut_right_J, y_cut_left_J:...
   y_cut_right_J);
Image_raw_U_Cut = Image_raw_U_Diff( x_cut_left_U:x_cut_right_U, y_cut_left_U:...
   y_cut_right_U);


% Image_NJU(:,1:81) = fliplr( flipud( (Image_raw_U_Cut) ) );
Image_NJU( 1:pixel_cut_number+1,1:(pixel_cut_number+1) ) = Image_raw_N_Cut;

Image_NJU( (pixel_cut_number+2+10):(pixel_cut_number*2+2+10),1: (pixel_cut_number+1) ) = Image_raw_J_Cut;
Image_NJU((pixel_cut_number*2+3+20):(pixel_cut_number*3+3+20),1: (pixel_cut_number+1)) = Image_raw_U_Cut;

save(strcat(file_name,'Image_NJU.txt'),'Image_NJU','-ascii')


% x_value_cut = linspace(1,pixel_cut_number+1,pixel_cut_number+1);
% y_value_cut = linspace(1,(pixel_cut_number+1)*3,(pixel_cut_number+1)*3);

x_value_cut = linspace(1,y_axis,y_axis);
y_value_cut = linspace(1,x_axis,x_axis);

[X_value_cut,Y_value_cut] = meshgrid(x_value_cut, y_value_cut);


figure(4)

surf(X_value_cut, Y_value_cut, Image_NJU);

view(90,90);

% view(0, 90);
axis tight
shading interp; 
set(gca,'Fontname', 'Arial','FontSize',22)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
colorbar
% set(gca,'xtick',(0:200:1000));
% set(gca,'ytick',(0:200:1000));
xlabel('Pixels')
ylabel('Pixels')   
set(gca,'tickdir','out')
set(gcf,'unit','centimeter','position',[10 5 30 12])
% set(gcf,'position',[centerX,centerY,width,height])
caxis([color_min,color_max]);
% 创建 line
annotation('line',[0.38 0.44538],...
    [0.8 0.8],'Color',[1 1 1],'LineWidth',6);
% 创建 textbox
% annotation('textbox',...
%     [0.365 0.81 0.1 0.09],...
%     'Color',[1 0 1],...
%     'String',{'200 \mum'},...
%     'HorizontalAlignment','center',...
%     'FontSize',22,...
%     'EdgeColor','none','Fontname', 'Times New Roman');
annotation('textbox',...
    [0.365 0.81 0.1 0.09],...
    'Color',[1 1 1],...
    'HorizontalAlignment','center',...
    'FontSize',22,...
    'EdgeColor','none','Fontname', 'Times New Roman');
saveas(gcf,'NJU_2.png');
set(gca,'Fontname', 'Times New Roman','FontSize',22)



x_value_cut = linspace(1,y_axis,y_axis)*13.3;
y_value_cut = linspace(1,x_axis,x_axis)*13.3;

[X_value_cut,Y_value_cut] = meshgrid(x_value_cut, y_value_cut);

figure(5)

surf(X_value_cut, Y_value_cut, Image_NJU);

view(90,90);

% view(0, 90);
axis tight
shading interp; 
set(gca,'Fontname', 'Times New Roman','FontSize',22)
% set(gca,'Fontname', 'Arial','FontSize',16,'FontWeight','bold')
colormap(hot)
colorbar
% set(gca,'xtick',(0:200:1000));
% set(gca,'ytick',(0:200:1000));
xlabel('\mum')
ylabel('\mum')   
set(gca,'tickdir','out')
set(gcf,'unit','centimeter','position',[10 5 30 12])
% set(gcf,'position',[centerX,centerY,width,height])
caxis([color_min,color_max]);


saveas(gcf,'NJU_3.png');