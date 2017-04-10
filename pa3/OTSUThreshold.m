function Threshold = OTSUThreshold(Input)
%%% Credited by Wikipedia "Otsu's method"
%%% Adjusted to match my project
[M, N] = size(Input);
Bins = 256;
Counter = zeros(1,256);
for k = 0:255
    for i = 1:M
        for j = 1:N
            if(Input(i,j) == k)
                Counter(k+1) = Counter(k+1) + 1; 
            end
        end
    end
end


Mean = Counter/ sum(Counter);

for i = 1 : Bins
   Mean_L = sum(Mean(1 : i));
   Mean_H = sum(Mean(i + 1 : end));
   Miu_L = sum(Mean(1 : i) .* (1 : i)) / Mean_L;
   Miu_H = sum(Mean(i + 1 : end) .* (i + 1 : Bins)) / Mean_H;
   Sigma(i) = Mean_L * Mean_H * (Miu_L - Miu_H)^2;
end

[~,Threshold] = max(Sigma(:));
Threshold = ceil(Threshold*0.95);

fprintf('The threshold is %d.\n', Threshold);
end
