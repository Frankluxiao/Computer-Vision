clear all; close all;

%% Hough Transformation

I_orig = imread('line1.jpg');  % Read original image
I_gray = rgb2gray(I_orig); % Convert RGB to Gray
I_doub = double(I_gray);   % Convert Uint8 to Double

[M, N] = size(I_doub);

% %% Edge Detection
% [I_edge, Theta] = SobelEdge(I_doub);
% 
% Threshold = 250;
% I_thre = I_edge;
% I_thre(I_thre < Threshold) = 0;
% I_thre(I_thre > 255) = 255;


%% Edge Detection
[I_edge, Theta] = RobertsEdge(I_doub);
Threshold = OTSUThreshold(I_edge);
I_thre = I_edge;
I_thre(I_thre < Threshold) = 0;
I_thre(I_thre > Threshold) = 255;

%% Hough Transformation
[Hough, Bins, Angles] = HoughTransformLine(I_thre);
L_Num = 6;
Position = HoughLinePeak(Hough, L_Num);


%% Matlab built-in Hough transform
I_01 = I_thre;         % Binarizaion
I_01(I_01 == 255) = 1;
[H,theta,rho] = hough(I_01);


%% Plot

figure(1),
subplot(2,2,1);
imshow(I_orig); title('Original Image');
subplot(2,2,2);
imshow(I_gray); title('Gray Image');
subplot(2,2,3);
imshow(I_edge); title('Edged Image');
subplot(2,2,4);
imshow(I_thre); title('Thresholded Image');

figure(2),
subplot(1,2,1);
image(Angles,Bins,Hough);
title('Hough Transform');
xlabel('Angel[ -1.57(-90°) ~ 1.57(89°)]');
ylabel('Distance[ -1000 ~ 1000 ]');

subplot(1,2,2);
image(theta,rho,H);
title('MATLAB Hough Transform');
xlabel('Angel[ -90° ~ 89° ]');
ylabel('Distance[ -1000 ~ 1000 ]');


figure(3),
image(Angles,Bins,Hough);
title('Location of peak points');
xlabel('Angel[ -1.57(-90°) ~ 1.57(89°)]');
ylabel('Distance[ -1000 ~ 1000 ]');
hold on;
plot(Position(:,1).*pi/180, Position(:,2), 's', 'color', 'white');
hold off;


figure(4),
image(I_orig);
title('Lines Reconstrction on Original Image')
color map('gray');
hold on;
for i = 1:L_Num
    x = 60:6:660;
    y = -(cosd(Position(i,1))/sind(Position(i,1)))*x + (Position(i,2)/sind(Position(i,1)));
    plot(x, y,'LineWidth',2);
    hold on;
end
grid on;
hold off; 
