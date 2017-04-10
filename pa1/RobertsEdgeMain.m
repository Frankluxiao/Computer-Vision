clear all;
close all;

%% My main implementation
%%% Input format: uint8
%%% Processing format: double
%%% Output format: uint8
A_origin = imread('Daisy.jpg'); % Read original image
A_gray = rgb2gray(A_origin); % convert original RGB image into Gray image
A = double(A_gray); % convert uint8 into double

[M, N] = size(A); 


%% Edge Detection
[G_origin, Theta] = RobertsEdge(A);

%% OTSU Threshold
Threshold = OTSUThreshold(G_origin);

%% Thresholding of the gradient magnitude

G_origin(G_origin > 255) = 255;
Input_vector = reshape(G_origin,[1, M*N]);
Bins = 256;
Counter = hist(Input_vector,Bins);
bar(Counter,0.3)

G_threshold = G_origin;
G_threshold(G_origin < Threshold) = 0;

G_threshold1 = G_origin;
G_threshold1(G_origin < 20) = 0;

G_threshold2 = G_origin;
G_threshold2(G_origin < 80) = 0;

G_threshold3 = G_origin;
G_threshold3(G_origin < 120) = 0;



%% Expansion
G_expand = Expansion(G_threshold, Threshold);
                
%% Thining
G_thin = Thining(G_expand, Threshold);

%% Modified thinning 
G_Thin = ThinningModified(G_thin);

%% Convert data format
G_gray = uint8(G_origin);
G_threshold = uint8(G_threshold);
G_threshold1 = uint8(G_threshold1);
G_threshold2 = uint8(G_threshold2);
G_threshold3 = uint8(G_threshold3);
G_thin = uint8(G_thin);
G_Thin = uint8(G_Thin);

%% Plot

figure(1),
subplot(1,3,1);
imshow(A_origin); title('Original');
subplot(1,3,2);
imshow(A_gray); title('Gray');
subplot(1,3,3);
imshow(G_gray); title('Edge');

figure(2), 
imshow(Theta,[]), title('Gradient direction [-\pi,\pi]')
colormap(hot), colorbar, caxis([-pi pi])

figure(3),
subplot(1,4,1);
imshow(G_threshold); title('Edge with OTSU-thresholding');
subplot(1,4,2);
imshow(G_threshold1); title('Edge with Manual-threshold = 20');
subplot(1,4,3);
imshow(G_threshold2); title('Edge with Manual-threshold = 80');
subplot(1,4,4);
imshow(G_threshold3); title('Edge with Manual-threshold = 120');

figure(4),
subplot(1,4,1);
imshow(G_gray); title('Edge');
subplot(1,4,2);
imshow(G_threshold); title('Edge with OTSU-thresholding');
subplot(1,4,3);
imshow(G_thin); title('Edge with thinning');
subplot(1,4,4)
imshow(G_Thin); title('Edge with modified-thinning');


%% Comparison with MATLAB function
G_orimat = edge(A, 'Roberts');

figure(5),
subplot(1,2,1);
imshow(G_Thin); title('My Function');
subplot(1,2,2);
imshow(G_orimat); title('MATLAB Function');
% figure(6),
% [Gmag,Gdir] = imgradient(A,'roberts');
% imshow(Gdir);