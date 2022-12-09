clear
clc
close all
Image_NJU = imread('NJU512.1.png');

N_pixels =512; %Number of pixel

x = 1:1:N_pixels;
y = 1:1:N_pixels;

[X,Y] = meshgrid(x,y);

Image_NJU_1 = zeros(N_pixels,N_pixels);
for i=1:N_pixels
    for j=1:N_pixels
        Image_NJU_1(i,j) = Image_NJU(i,j);
    end
end

% Data transform and normalization
Transmitivity = 0.5;
Image_NJU_Norm= ( - double(Image_NJU_1)/255+1)* Transmitivity; 

%% NJU interference

Image_NJU_Interference = zeros(N_pixels,N_pixels);
Image_NJU_Interference1 = zeros(N_pixels,N_pixels);
Image_NJU_Interference2 = zeros(N_pixels,N_pixels);


Photon_num = 50;
interference_rand1 = rand(N_pixels,N_pixels)*2-1;
interference_rand2 = rand(N_pixels,N_pixels)*2-1;

phase_N = 0;
phase_J = pi/4;
phase_U = 3*pi/4;

theta1 = 0;

for i=1:N_pixels
    for j=1:N_pixels
        if j<=171
            Image_NJU_Interference1(i,j) =   real( Photon_num*( 1 + Image_NJU_Norm(i,j)*exp( 1i*(theta1 + phase_N) ) )...
                *( 1 + Image_NJU_Norm(i,j)*exp( -1i*(theta1 + phase_N) ) ) ) + Photon_num*( 1- Image_NJU_Norm(i,j)^2)...
                +interference_rand1(i,j)*sqrt(4*Photon_num);
        elseif (j>171)&&(j<=342)
            Image_NJU_Interference1(i,j) =   real( Photon_num*( 1 + Image_NJU_Norm(i,j)*exp( 1i*(theta1 + phase_J) ) )...
                *( 1 + Image_NJU_Norm(i,j)*exp( -1i*(theta1 + phase_J) ) ) ) + Photon_num*( 1- Image_NJU_Norm(i,j)^2)...
                +interference_rand1(i,j)*sqrt(4*Photon_num);
        else 
            Image_NJU_Interference1(i,j) =   real( Photon_num*( 1 + Image_NJU_Norm(i,j)*exp( 1i*(theta1 + phase_U) ) )...
                *( 1 + Image_NJU_Norm(i,j)*exp( -1i*(theta1 + phase_U) ) ) ) + Photon_num*( 1- Image_NJU_Norm(i,j)^2)...
                +interference_rand1(i,j)*sqrt(4*Photon_num);
        end
    end
end

theta2 = pi;

for i=1:N_pixels
    for j=1:N_pixels
        if j<=171
            Image_NJU_Interference2(i,j) =   real( Photon_num*( 1 + Image_NJU_Norm(i,j)*exp( 1i*(theta2 + phase_N) ) )...
                *( 1 + Image_NJU_Norm(i,j)*exp( -1i*(theta2 + phase_N) ) ) ) + Photon_num*( 1- Image_NJU_Norm(i,j)^2)...
                +interference_rand2(i,j)*sqrt(4*Photon_num);
        elseif (j>171)&&(j<=342)
            Image_NJU_Interference2(i,j) =   real( Photon_num*( 1 + Image_NJU_Norm(i,j)*exp( 1i*(theta2 + phase_J) ) )...
                *( 1 + Image_NJU_Norm(i,j)*exp( -1i*(theta2 + phase_J) ) ) ) + Photon_num*( 1- Image_NJU_Norm(i,j)^2)...
                +interference_rand2(i,j)*sqrt(4*Photon_num);
        else 
            Image_NJU_Interference2(i,j) =   real( Photon_num*( 1 + Image_NJU_Norm(i,j)*exp( 1i*(theta2 + phase_U) ) )...
                *( 1 + Image_NJU_Norm(i,j)*exp( -1i*(theta2 + phase_U) ) ) ) + Photon_num*( 1- Image_NJU_Norm(i,j)^2)...
                +interference_rand2(i,j)*sqrt(4*Photon_num);
        end
    end
end

Image_NJU_Interference = Image_NJU_Interference1 -Image_NJU_Interference2;



%% Figure



figure(1)
h= surf(X,Y,Image_NJU_Norm);
set(h,'edgecolor','none');
view([0,-90])
colormap(hot)
caxis([0 1])
axis tight
colorbar
set(gca,'Fontsize',22)
saveas(gcf,'Image_NJU_N.png')


caxis_min = -10;
caxis_max = 4*Photon_num +10;

figure(2)
h= surf(X,Y,Image_NJU_Interference1);
set(h,'edgecolor','none');
view([0,-90])
colormap(hot)
colorbar
axis tight
set(gca,'Fontsize',22)
% saveas(gcf,'Image_NJU_Interference.png')
caxis([caxis_min caxis_max])


figure(3)
h= surf(X,Y,Image_NJU_Interference2);
set(h,'edgecolor','none');
view([0,-90])
colormap(hot)
colorbar
axis tight
set(gca,'Fontsize',22)
% saveas(gcf,'Image_NJU_Interference.png')
caxis([caxis_min caxis_max])


caxis_diff_min = -2*Photon_num;
caxis_diff_max = 2*Photon_num;

% caxis_diff_min = -10;
% caxis_diff_max = 2*Photon_num +10;

figure(4)
h= surf(X,Y,Image_NJU_Interference);
set(h,'edgecolor','none');
view([0,-90])

colormap(hot)
colorbar
axis tight
set(gca,'Fontsize',22)
% saveas(gcf,'Image_NJU_Interference.png')
caxis([caxis_diff_min caxis_diff_max])

