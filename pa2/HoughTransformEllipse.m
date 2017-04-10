function [Best_ellipse, Prmts] = HoughTransformEllipse(I_01, K_Num)


%% Randomized Hough transform
%Ratio = 1.0; % Default for whole data
[M, N] = size(I_01);
[Col_index, Row_index] = find(I_01 == 1); % Location of edge points
E_Nums = length(Row_index); % Number of edge points
% Edge_index = [Row_index, Col_index];
%Spl_num = ceil(E_Nums*Ratio); % Random number
% Rand_num = randperm(E_Nums,Spl_num); 
% Edge_rand = [Row_index(Rand_num),Col_index(Rand_num)]; % Random edge sets
Edge_rand = [Row_index,Col_index];

D_MIN = 8;
Vote_MIN = 70;


Distance = norm([M,N]); % Set distance
Acmlt = zeros(Distance, 100000); % Accumulator matrix dimension
                                      % High dimension for Debug
                                      % We can optimize it by setting it as vector
Prmts = zeros(4, 6);
n = 1;% Index for parameter container
m = 1;% Index for accumulator    
fprintf('This image has %d sets of edge points.\n', E_Nums-1);
for i = 1:E_Nums-1
    fprintf('Calculate No.%d sets, total sets number is %d.\n', i, E_Nums-1);
    for j = i+1:E_Nums
        P_x(1) = Edge_rand(i,1); % Point 1
        P_y(1) = Edge_rand(i,2); 
        P_x(2) = Edge_rand(j,1); % Point 2
        P_y(2) = Edge_rand(j,2);
        D_12 = sqrt((P_y(2)-P_y(1))^2+(P_x(2)-P_x(1))^2); % Distance between 1,2
        if ((D_12 >= D_MIN) && (P_x(2)- P_x(1) > 2))
            P_x0 = (P_x(1)+P_x(2))/2; % Equation(1):x0
            P_y0 = (P_y(1)+P_y(2))/2; % Equation(2):y0
            A = sqrt((P_y(2)-P_y(1))^2+(P_x(2)-P_x(1))^2)/2; % Equation(3): Length of major axis
            Alpha = atan((P_y(2)-P_y(1))/(P_x(2)-P_x(1))); % Equation(4): Orientation of ellipse
            if Alpha == 0
                for k = 1:E_Nums
                    P_x(3) = Edge_rand(k,1); % Point 3
                    P_y(3) = Edge_rand(k,2);
                    D_30 = sqrt((P_y(3)-P_y0)^2+(P_x(3)-P_x0)^2); % Distance between 3,0
                    if((k ~= i)&&(k ~= j)&&(D_30 < A))
                        F = sqrt((P_y(3)-P_y(2))^2+(P_x(3)-P_x(2))^2);
                        cos_t = (A^2 + D_30^2 - F^2)/(2*A*D_30); % Equation(6)
                        cos_2t = cos_t^2;
                        sin_2t = 1 - cos_2t;
                        B_2 = (A^2*D_30^2*sin_2t)/(A^2-D_30^2*cos_2t); % Equation(5)
                        B = real(ceil(sqrt(B_2))); % Avoid complex number
                        if B > 10 && B <= Distance
                            Acmlt(B,m) = Acmlt(B,m)+1; % Accumulate count
                        end                  
                    end
                end
                [Score, ~] = max(Acmlt(:,m)); 
                m = m + 1;
                if ((Score > Vote_MIN) && (B <= 70) &&(B >= 14))
                    Prmts(n,:)  = [P_x0, P_y0, A, B, Alpha, Score]; % Store parameters
                    n = n + 1;
                end
            end
        end
    end
end

fprintf('Finished calculation.\n');


%% Choose the best ellipse
%%%% Method 1
% fprintf('Choose the best %d ellipses.\n',K_Num);
% Best_ellipse = zeros(K_Num,5);
% [score, index] = sort(Prmts(:,6),'descend');
% Prmts = Prmts(index,1:5);
% Best_ellipse(1,:) = Prmts(1,:);
% Best_temp = Prmts;
% for i = 2:K_Num   
%     X0 = Best_temp(1,1);
%     X1 = Best_temp(:,1);
%     X_d = abs(bsxfun(@minus,X1,X0));
%     Best_temp = Best_temp((X_d >= 20),:);
%     Best_ellipse(i,:) = Best_temp(1,:);
% end

%%%% Method 2
[~, Best_ellipse] = kmeans(Prmts,K_Num);

end