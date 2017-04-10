function [Hough, Bins, Angles] = HoughTransformLine1(I_input)

[M, N] = size(I_input);
%%% %%% We just focus on the points that has value equal to 1
I_01 = I_input;         % Binarizaion
I_01(I_01 == 255) = 1;

[Row_index, Col_index] = find(I_01 == 1); % Location of edge points 
E_Nums = length(Row_index); % Number of edge points
Distance = norm([M,N]); % Set distance 
D_Rslt = 1; % Set distance resolution
D_Nums = 2*Distance/D_Rslt + 1; % Number of distance

A_Rslt = pi/180; % Set angle resolution
A_Nums = 180; % Number of angle
Angles = -pi/2:A_Rslt:pi/2;

Acmlt = zeros(E_Nums, A_Nums); % Accumulator matrix dimension
Hough = zeros(D_Nums, A_Nums); % Hough matrix dimesion

for i = 1:E_Nums
    for j = 1:A_Nums
        Acmlt(i,j) = Col_index(i)*cos(Angles(j))+ Row_index(i)*sin(Angles(j));
    end
end

% Obtain histgram of all the distance at each degree
Bins = (-Distance:1:Distance);
for k = 1:180
   Hough(:,k) = hist(Acmlt(:,k),Bins);
end



end