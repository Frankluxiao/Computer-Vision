close all;
clear all;

I_orig = imread('Test2.jpg');
I_gray = rgb2gray(I_orig);
I_doub = double(I_gray);
[M, N] = size(I_doub);

%% Histogram
Histogram = MyHistogram(I_doub);

%% Thresholding and binarization 
% Working on points which value equal to 1 
Threshold = 250;
I_01 = I_doub;
I_01(I_01 <  250) = 1;
I_01(I_01 >= 250) = 0;

%% Grassfire algorithm   
[I_grsf, MAX, MIN] = MyGrassfire(I_01);

%% Plot with comparison
figure,
subplot(1,2,1);
imshow(I_orig);
title('Original Image');
color map('gray');

subplot(1,2,2);
imshow(I_grsf,[MIN, MAX]);
title('Image with Grassfire Transform');
color map('gray')
