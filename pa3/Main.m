clear all; close all;      
I_orig = imread('reg4.jpg');  % Read original image
I_doub = double(I_orig);   % Convert uint8 to double
I_doub = Preprocessing(I_doub); % Preprocessing

%% Q1 Histogram the Intensity Values
%  1.1 Smoothing
I_smth = Smooth(I_doub);

%  1.2 Histogram
I_hist = Histogram(I_smth);

%  1.3 Thresholding
Threshold = OTSUThreshold(I_doub);

%% Q2 Connected Region Extraction
%  2.1 Binarization
I_01 = I_doub;
%I_01 = double(I_smth);
I_01 (I_01 <= Threshold) = 1;
I_01 (I_01 >  Threshold) = 0;

%  2.2 Simple Raster Scan
[I_output, Label_Class] = RasterScan(I_01);

%% Q3 Computation of Blob Statistics
%  3.1 Analysis for blob
Parameter = BlobStatistics(I_output, Label_Class);