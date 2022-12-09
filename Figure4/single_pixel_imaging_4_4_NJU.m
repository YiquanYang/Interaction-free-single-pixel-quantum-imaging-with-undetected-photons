clear
close all;


% file_name = 'C:\Users\Ethan\Desktop\微云同步\【1】实验记录\4、实验数据记录\20211130\NJU\'; 


color_min = 0;
color_max = 12;

Image_raw_N1 = importdata('N_Original_image_810.txt');
Image_raw_J1 = importdata('J_Original_image_810.txt');
Image_raw_U1 = importdata('U_Original_image_810.txt');



%% NJU 91*91



dim_rotate = 91;

Image_NJU = color_max*ones(dim_rotate*3+20, dim_rotate);

Image_NJU( 1:dim_rotate,1:dim_rotate ) = Image_raw_N1' ;

Image_NJU( (dim_rotate+1+10):(dim_rotate*2+10),1:dim_rotate ) = Image_raw_J1' ;
Image_NJU( (dim_rotate*2+1+20):(dim_rotate*3+20),1:dim_rotate ) = Image_raw_U1' ;

x_value = linspace(1,dim_rotate,dim_rotate);
y_value = linspace(1,dim_rotate*3+20,dim_rotate*3+20);

[X_value,Y_value] = meshgrid(x_value, y_value);

Image_NJU_1 = fliplr( flipud( (Image_NJU) ) );

figure(2)

surf(X_value, Y_value, Image_NJU);


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
annotation('line',[0.39 0.44285],...
    [0.8 0.8],'Color',[1 1 1],'LineWidth',6);
% 创建 textbox
% annotation('textbox',...
%     [0.366 0.81 0.1 0.09],...
%     'Color',[1 0 1],...
%     'String',{'500 \mum'},...
%     'HorizontalAlignment','center',...
%     'FontSize',22,...
%     'EdgeColor','none','Fontname','Times New Roman');
annotation('textbox',...
    [0.366 0.81 0.1 0.09],...
    'Color',[1 1 1],...
    'HorizontalAlignment','center',...
    'FontSize',22,...
    'EdgeColor','none','Fontname','Times New Roman');
saveas(gcf,'NJU_2.png');

set(gca,'Fontname','Times New Roman')

