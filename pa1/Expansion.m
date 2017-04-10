function Expand = Expansion(A, Threshold)
display('--- Expansion Step ---');
fprintf('\n');

[M, N] = size(A); 
Expand = zeros(M, N);
% Binarization
Expand(A > Threshold) = 1;
Expand(A <= Threshold) = 0;
iteration = 1;
while(iteration < 6)
    display(['Expansion iteration = ', num2str(iteration)])

    for i=2:M-1
        for j=2:N-1
            Pos(1) = Expand(i,   j);
            Pos(2) = Expand(i-1, j);
            Pos(3) = Expand(i,   j+1);
            Pos(4) = Expand(i+1, j);
            Pos(5) = Expand(i,   j-1);
            Number = sum(Pos(2:5));
            if (Number == 4)
                Expand(i,j) = 1;
            end
        end
    end
    iteration = iteration + 1;
    
end

% Convert to uint8 format
Expand(Expand == 1) = 255;
Expand(Expand == 0) = 0;
fprintf('\n');
end