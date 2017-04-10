function Thin = Thining(A, Threshold)
%%%%%% The format of input image should be "double", or we need the
%%%%%% following step.
% Input = double(Input) 
% 
%     [ 9 2 3 ]
% A = | 8 1 4 |
%     [ 7 6 5 ]
%
display('--- Thining Step ---');
fprintf('\n');
% Dimensions
[M, N] = size(A); 
Binary = zeros(M, N);
Thin = zeros(M, N); % Thinned image

% Binarization
Binary(A > Threshold) = 1;
Binary(A <= Threshold) = 0;

% Start thining
iteration = 1;
flag = 1;
while flag && iteration < 1000;
    display(['Thining iteration = ', num2str(iteration)]);
    
    flag = 0;
    Mark = zeros(M, N); % Mark matrix
    
    for j = 2:N-1
        for i = 2:M-1    
            % Deal with the position with value = 1.
            if (Binary(i,j) > 0)
                Pos(1) = Binary(i,   j); 
                Pos(2) = Binary(i-1, j);
                Pos(3) = Binary(i-1, j+1); 
                Pos(4) = Binary(i,   j+1);
                Pos(5) = Binary(i+1, j+1);
                Pos(6) = Binary(i+1, j);
                Pos(7) = Binary(i+1, j-1);
                Pos(8) = Binary(i,   j-1);
                Pos(9) = Binary(i-1, j-1);
                             
                % Count N()
                N = sum(Pos(2:9));
                
                % Count S()
                S = 0;
                transition = Pos(9);                
                for k = 2:9                      
                    if (Pos(k) + transition) == 1
                        S = S + 1;
                    end
                    transition = Pos(k);                
                end
                S = S/2;
                
                % Check remove condition
                PP1 = Pos(2)*Pos(4)*Pos(6);
                PP2 = Pos(4)*Pos(6)*Pos(8);
                if (Pos(1)==1 && N>=2 && N<=6 && S==1 && PP1 == 0 && PP2 == 0 && Pos(7) ~= 0)
                    Mark(i,j) = 1;
                end
                
                
%                 if(Pos(2) == 1 && Pos(4) == 1)
%                     Mark(i,j) = 1;
%                 end
%                 if(Pos(2)==1 && Pos(9) == 1 && sum(Pos(3:8))==0)
%                     Mark(i,j) = 1;
%                 end
                                           
            end
        end 
    end
    
    % Delete marked pixel
    Binary(Mark > 0) = 0;
    
    % Check flag
    if sum(Mark(:)) > 0
        flag = 1;
    end    
    iteration = iteration + 1;
    
end

% Convert to uint8 format
Thin(Binary == 1) = 255;
Thin(Binary == 0) = 0;
fprintf('\n');
end