clear all; close all;

%% Hough Transformation

I_orig = imread('ellipse1.jpg');  % Read original image
I_gray = rgb2gray(I_orig); % Convert RGB to Gray
I_doub = double(I_gray);   % Convert Uint8 to Double

[M, N] = size(I_doub);

%% Edge Detection
[I_edge, Theta] = RobertsEdge(I_doub);
Threshold = OTSUThreshold(I_edge);

I_thre = I_edge;
I_thre(I_thre < Threshold) = 0;   % Bipolarization
I_thre(I_thre > Threshold) = 255;

I_01 = I_thre;         % Binarizaion
I_01(I_01 == 255) = 1;
%% Hough Transformation
K_Num = 4; % Number of ellipses
[Best_ellipse, Prmts] = HoughTransformEllipse(I_01, K_Num);

%% Draw ellipses
DrawEllipse(I_orig, Best_ellipse, K_Num);

%% Plot center of potential ellipses

figure,
scatter(Prmts(:,1), Prmts(:,2));
title('Center of potential ellipses'); % Debug

