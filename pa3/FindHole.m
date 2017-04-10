function [N_hole, Area_hole] = FindHole(I_input,kk)
%   8-direction connectivity
%   [ 1     2    3 ]
%   | 4  Center  5 |
%   [ 6     7    8 ]
%I_input = importdata('IV4.mat');
%First Pass
%I_orig = I_input;
[M, N] = size(I_input);
Label = 2; % Only work on the points with value = 1
Link_orig = cell(1,1); % Original Link table
Link_orig{1,1} = 2;
k = 2;
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
    fprintf('Finished %.2f%% for blob number %d.\n',Percentage, kk);
    
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
L_Link_redc = length(Link_redc);
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
    if Counts(i) > 0
        Label_Class(j,1) = Counts(i);
        Label_Class(j,2) = i-1;
        j = j+1;
    end
end

% Find Holes
[MC, NC] = size(Label_Class);
N_hole = MC-1;
Area_hole = Label_Class(:,1);
Area_hole = Area_hole(2:end,:);
Area_hole = sum(Area_hole);

end