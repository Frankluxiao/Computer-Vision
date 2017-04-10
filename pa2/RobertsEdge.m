function [G, Theta] = RobertsEdge(A)
%%
%       [ 1   0 ]             [ 0   1 ] 
% G_x = |       | * A   G_y = |       | * A
%       [ 0  -1 ]             [-1   0 ]
%
% Where A is source image, G_x and G_y are two images 
% which at each point contain the horizontal and vertical 
% derivative approximations respectively. 
%
% Gradient magnitude: G = sqrt((G_x)^2 + (G_y)^2))
%
% Gradient's direction: Theta = actan(G_y, G_x)

%% 
[M, N] = size(A);
G = zeros(M, N);
Theta = zeros(M, N);
for i=1:M-1
    for j=1:N-1
        % X-axis Roberts mask
        G_x=(A(i,j)-A(i+1,j+1));
        % Y-axis Roberts mask
        G_y=(A(i+1,j)-A(i,j+1));     
        % Gradient magnitude
        G(i,j)=sqrt(G_x.^2+G_y.^2);
%         % Set threshold
%         if(G(i,j) < 30)
%             G(i,j) = 0;
%         end
%         if (G(i,j)> 200)
%             G(i,j) = 255;
%         end
        Theta(i,j) = atan2(G_y,G_x);
      
    end
end

end
