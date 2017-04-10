function [G, Theta] = SobelEdge(A)
%%%%%%
%       [ -1 0 1 ]             [ -1 -2 -1 ] 
% G_x = | -2 0 2 | * A   G_y = |  0  0  0 | * A
%       [ -1 0 1 ]             [  1  2  1 ]
%
% Where A is source image, G_x and G_y are two images 
% which at each point contain the horizontal and vertical 
% derivative approximations respectively. 
%
% Gradient magnitude: G = sqrt((G_x)^2 + (G_y)^2))
%
% Gradient's direction: Theta = atan2(G_y, G_x)

%% Edge Detection
[M, N] = size(A);
G = zeros(M, N); % Gradient magnitude
Theta = zeros(M, N); % Gradient's direction
for i=1:M-2
    for j=1:N-2
        % X-axis Sobel template
        G_x =((2*A(i+2,j+1)+A(i+2,j)+A(i+2,j+2))-(2*A(i,j+1)+A(i,j)+A(i,j+2)));
        % Y-axis Sobel template
        G_y =((2*A(i+1,j+2)+A(i,j+2)+A(i+2,j+2))-(2*A(i+1,j)+A(i,j)+A(i+2,j)));     
        % Gradient magnitude
        G(i,j)=sqrt(G_x.^2+G_y.^2);        
%         % Set threshold
%         if(G(i,j) < OTSU_threshold) 
%             G(i,j) = 0;
%         end
%         if (G(i,j)> 250)
%             G(i,j) = 255;
%         end        
        Theta(i,j) = atan2(G_y, G_x);      
    end
end
