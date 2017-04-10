function perimeter = Perimeter(I_input)

%%% Check perimeter
[MI,NI] = size(I_input);
Flag = 0;
% Find start point
P_start = zeros(1,2);
dir = zeros(1,1);
for i = 2:MI-1
    for j = 2:NI-1
        if I_input(i  ,j  ) == 1
            P_start = [i,j];
            dir(1) = 7;
            Flag = 1;
            break;
        end
    end
    if Flag == 1
        break;
    end
end


% Initializaiton
Border_location = zeros(1,2);
x = P_start(1,1);
y = P_start(1,2);
Index = 1;

% Iterative find the end point
while ((Border_location(Index,1) ~= P_start(1,1))||(Border_location(Index,2) ~= P_start(1,2)))
    Border_location(1,1) = x;
    Border_location(1,2) = y;
    
    % [3 2 1]    [4 3 2]
    % |4 C 0|    |5 C 1|
    % [5 6 7]    [6 7 8]
    % Neighbor[1.x, 2.y, 3.value]
    
    Neighbor(1,:) = [x  ,y+1,I_input(x  ,y+1)];
    Neighbor(2,:) = [x-1,y+1,I_input(x-1,y+1)];
    Neighbor(3,:) = [x-1,y  ,I_input(x-1,y  )];
    Neighbor(4,:) = [x-1,y-1,I_input(x-1,y-1)];
    Neighbor(5,:) = [x  ,y-1,I_input(x  ,y-1)];
    Neighbor(6,:) = [x+1,y-1,I_input(x+1,y-1)];
    Neighbor(7,:) = [x+1,y  ,I_input(x+1,y  )];
    Neighbor(8,:) = [x+1,y+1,I_input(x+1,y+1)];
    Neigh = repmat(Neighbor,[2,1]);
    
    L_dir = length(dir);
    if dir(L_dir)/2 == 0
        start = mod(dir(L_dir)+7,8);
    else
        start = mod(dir(L_dir)+6,8);
    end
    
    
    for i = start+1:16
        if Neigh(i,3) == 1
            True_i = mod(i-1,8);
            dir(end+1) = True_i;
            x = Neigh(True_i+1,1);
            y = Neigh(True_i+1,2);
            Border_location(end+1,1) = x;
            Border_location(end,2) = y;
            break;
        end
    end
    
    [Index,~] = size(Border_location);
    
end


figure,
imshow(I_input);
title('Perimeter plot for blob');
hold on;
a = 10;
scatter(Border_location(:,2),Border_location(:,1),a,'r');
hold off;

perimeter = size(Border_location(:,1),1);
end






