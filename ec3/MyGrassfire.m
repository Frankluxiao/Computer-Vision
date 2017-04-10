function [I_input, MAX, MIN] = MyGrassfire(I_input)


%%% %%% %%% %%% %%%
%%% Pseudocode  %%%
%%% %%% %%% %%% %%%

%   for each row in image left to right
%     for each column in image top to bottom
%       if(pixel is in region){
%         set pixel to 1 + minimum value of the north and west neighbours
%       }else{
%         set pixel to zero
%       }
%     }
%   }
% 
%   for each row right to left
%     for each column bottom to top
%       if(pixel is in region){
%         set pixel to min(value of the pixel,1 + minimum value of the south and east neighbours)
%       }else{
%         set pixel to zero
%       }
%     }
%   }


%         8-connectivity
%          P1   P2   P3
%          P4  (i,j) Q1
%          Q2   Q3   Q4
[M, N] = size(I_input);

% First Pass
for i = 2:M                % Row index
    for j = 2:N-1          % Colomn index
        if (I_input(i,j) > 0)
            P(1) = I_input(i-1,j-1);
            P(2) = I_input(i-1,j  );
            P(3) = I_input(i-1,j+1);
            P(4) = I_input(i,  j-1);
            P_Min = min(P);
            I_input(i, j) = P_Min + 1;
        end

    end
end

% Second Pass
for i = M-1:-1:1           % Row index
    for j = N-1:-1:2       % Colomn index
        if (I_input(i,j) > 0)                      
            Q(1) = I_input(i,  j+1);
            Q(2) = I_input(i+1,j-1);
            Q(3) = I_input(i+1,j  );
            Q(4) = I_input(i+1,j+1);
            Q_min = min(Q);
            I_input(i, j) = min([I_input(i,j), Q_min+1]);       
        end
    end
end

% Obtain the max and min number in whole image
MAX = max(max(I_input));
MIN = min(min(I_input));

end