function Threshold = OTSUThreshold(Input)
%%% Credited by Wikipedia "Otsu's method"
%%% Adjusted to match my project
[M, N] = size(Input);
Input_vector = reshape(Input,[1, M*N]);
Bins = 256;
Counter = hist(Input_vector,Bins);
Mean = Counter/ sum(Counter);

for i = 1 : Bins
   Mean_L = sum(Mean(1 : i));
   Mean_H = sum(Mean(i + 1 : end));
   Miu_L = sum(Mean(1 : i) .* (1 : i)) / Mean_L;
   Miu_H = sum(Mean(i + 1 : end) .* (i + 1 : Bins)) / Mean_H;
   Sigma(i) = Mean_L * Mean_H * (Miu_L - Miu_H)^2;
end

[~,Threshold] = max(Sigma(:));
end
