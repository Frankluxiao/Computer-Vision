function Parameter = BlobStatistics(I_input, L_input)
% 1-4.MBR(MaxX, MinX, MaxY, MinY) 5-6. Centroid(CT_X, CT_Y) 7.Area
% 8.Perimeter 9.Number of holes 10.Total area of holes 11.Elongation
% II_input = importdata('BII.mat');
% LL_input = importdata('BLL.mat');
[MI, NI] = size(I_input);
[ML, NL] = size(L_input);
I_temp = zeros(MI, NI);
Parameter = zeros(ML, 11);
for kk = 1:ML
    fprintf('Calculating parameters for blob Number %d.\n',kk);
   
    I_temp(I_input == L_input(kk,2)) = 1;    
%     I_output = I_temp;
%     I_output(I_output == 1) = 255;
%     
    [X, Y] = find(I_temp == 1);
    Max_X = max(X);
    Max_Y = max(Y);
    Min_X = min(X);
    Min_Y = min(Y);
    CT_X = ceil((Max_X+Min_X)/2);
    CT_Y = ceil((Max_Y+Min_Y)/2);
    Area = length(X);
    
    % Store first 7 parameters
    Parameter(kk,1) = Max_X;
    Parameter(kk,2) = Min_X;
    Parameter(kk,3) = Max_Y;
    Parameter(kk,4) = Min_Y;
    Parameter(kk,5) = CT_X;
    Parameter(kk,6) = CT_Y;
    Parameter(kk,7) = Area;
    
    % Calculate perimeter
    Parameter(kk,8) = Perimeter(I_temp);
    %Para{i,1} = bwboundaries(I_temp);
    
    % Number of holes
    % Plot and check each part
    I_invrt = I_temp;
    I_invrt(I_temp == 0) = 1;
    I_invrt(I_temp == 1) = 0;
    
    [N_hole, Area_hole] = FindHole(I_invrt,kk);
    Parameter(kk,9) = N_hole;
    Parameter(kk,10) = Area_hole;
    Parameter(kk,11) = Parameter(kk,8)^2/Parameter(kk,7);
    
    I_temp = I_temp*0; % Reset I_temp
end


% Plot
figure,
imshow(I_input);
title('Result Image');
hold on;
scatter(Parameter(:,6),Parameter(:,5),'*','b');
hold on;
Class = size(L_input,1);
for i = 1:Class
    a = Parameter(i,4);
    b = Parameter(i,2);
    c = Parameter(i,3)-Parameter(i,4);
    d = Parameter(i,1)-Parameter(i,2);
    rectangle('Position',[a, b, c, d],'EdgeColor','y')
end

% Save
Temp_Para = dataset({Parameter 'Max_X','Min_X','Max_Y','Min_Y','CT_X','CT_Y','Area','Prmt','N_Hole','A_Hole','Elongation'});
export(Temp_Para, 'file', 'BlobStatistic.txt', 'delim', '\t');
end










