function [I_output, Label_Class] = RasterScan(I_input)
%   8-direction connectivity
%   [ 1     2    3 ]
%   | 4  Center  5 |
%   [ 6     7    8 ]

%First Pass
I_orig = I_input;
fprintf('Start raster scan.\n');
[M, N] = size(I_input);
Label = 2; % Only work on the points with value = 1
Link_orig = cell(2,1); % Original Link table
k = 1;
for i = 2:M-1
    for j = 2:N-1
        P_Center = I_input(i  ,j  );
        if P_Center == 1
            P(1) = I_input(i-1,j-1);
            P(2) = I_input(i-1,j  );
            P(3) = I_input(i-1,j+1);
            P(4) = I_input(i  ,j-1);
            P(5) = I_input(i  ,j+1);
            P(6) = I_input(i+1,j-1);
            P(7) = I_input(i+1,j  );
            P(8) = I_input(i+1,j+1);
            Index_P = find(P > 1); % Count label of neighbor
            if (isempty(Index_P)) % No neighbor
                I_input(i,j) = Label;
                Label = Label + 1;
            else
                Min_P = min(P(Index_P)); % Smallest label of neighbor
                I_input(i,j) = Min_P; % Assigh label
                N_Neighbor = length(unique(P(Index_P)));
                if N_Neighbor > 1 % Store link if the number of link is larger than 2
                    Link_orig{k,1} = unique(P(Index_P));
                    k = k + 1;
                end
            end
        end
    end
end

% Reduce size of link
Link_redc = cell(1,1);
L_Link = length(Link_orig);
Link_redc{1,1} = Link_orig{1,1};
Index = 1;

for i = 2:L_Link
    
    Percentage = i*100/L_Link; % Indication for progress
    fprintf('Finished %.2f%% of raster scan for whole image.\n',Percentage);
    
    for j = 2:L_Link
        if (size(intersect(Link_redc{Index,1},Link_orig{j,1})) > 0)
            Link_redc{Index,1} = unique([Link_redc{Index,1},Link_orig{j,1}]);
        end
    end
    
    L_Link_redc = length(Link_redc);
    count = 0;
    for k = 1:L_Link_redc
        count = count + double(isempty(intersect(Link_redc{k,1}, Link_orig{i,1})));
    end
    
    if count == L_Link_redc
        Index = Index + 1;
        Link_redc{Index,1} = Link_orig{i,1};
    end
end

% Find the smallest label among Link
for i = 1:L_Link_redc
    Min_Link(i,1) = min(Link_redc{i,1});
end

for i = 1:L_Link_redc
    Temp = Link_redc{i,1};
    L_Temp = length(Temp);
    for j = 1:L_Temp
        I_input(I_input == Temp(1,j)) = Min_Link(i,1);
    end
end

% Second Pass
% Reassigh label
a = max(max(I_input));
[Counts,centers] = hist(reshape(I_input,[1,M*N]),a+1);
L_Counts = length(Counts);
Label_Class = zeros(1,2);
j = 1;
for i = 3:L_Counts
    if Counts(i) > 1
        Label_Class(j,1) = Counts(i);
        Label_Class(j,2) = i-1;
        j = j+1;
    end
end
I_output = I_input;

% Coloration and plot

figure,
subplot(1,2,1);
imshow(I_orig);
title('Original Image');

subplot(1,2,2);
imshow(I_input);
hold on;
[L_Label,~] = size(Label_Class); 
a = 0.1;
for i = 1:L_Label
    [x,y] = find(I_input == Label_Class(i,2));
    scatter(y,x,a,'filled');
end
title('Extracted Image');
hold off;

end