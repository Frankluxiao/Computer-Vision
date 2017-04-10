function Thin = ThinningModified(A)

display('--- Modified Thining Step ---');
fprintf('\n');

% Dimension
[M, N] = size(A); 
Binary = zeros(M, N);
Thin = zeros(M, N);

% Binarization
Binary(A == 255) = 1;

%     [ 9 2 3 ]
% A = | 8 1 4 |
%     [ 7 6 5 ]


% Start thining
iteration = 1;
flag = 1;
while flag && iteration < 1000;
    display(['Modified thining iteration = ', num2str(iteration)]);
    flag = 0;
    Mark = zeros(M, N);
    
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
                
                % Check remove condition 
                if(Pos(2) == 1 && Pos(4) == 1)
                    Mark(i,j) = 1;
                end
                if(Pos(2)==1 && Pos(9) == 1 && sum(Pos(3:8))==0)
                    Mark(i,j) = 1;
                end
%                 PP1 = sum(Pos(6:9));
%                 PP2 = sum(Pos(5:8));
%                 PP3 = sum(Pos(3:6));
%                 PP4 = sum(Pos(4:7));
%                 PP5 = sum(Pos(2:4))+Pos(9);
%                 PP6 = sum(Pos(2:5));
%                 PP7 = sum(Pos(7:9))+Pos(2);
%                 PP8 = sum(Pos(2:3))+sum(Pos(8:9));
%                 if ((PP1==0 && PP2==0 && Pos(2) == 1 && Pos(4) == 1) || (PP3==0 &&PP4==0 && Pos(2) == 1 && Pos(8) == 1) || (PP7 == 0 &&PP8 ==0&& Pos(4) == 1 && Pos(6) == 1) || (PP5 == 0 &&PP6==0&& Pos(6) == 1 && Pos(8) == 1))
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