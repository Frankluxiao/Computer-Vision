function I_input = Preprocessing(I_input) 
[M, N] = size(I_input);
for i = 1:M
    for j = 1:N
        if j < 3 || j > N-4 || i < 2 || i > M-3
            I_input(i,j) = 100;
        end
    end
end