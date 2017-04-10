function Histogram = MyHistogram(I_input)
[M, N] = size(I_input);   % Input image should be 2-D with double format
Histogram = zeros(1,256);
for k = 0:255
    for i = 1:M
        for j = 1:N
            if(I_input(i,j) == k)
                Histogram(k+1) = Histogram(k+1) + 1; 
            end
        end
    end
end

 
% Plot
figure,
bar((0:255),Histogram,'b');
grid on;
title('Intensity Histogramg');
xlabel('0 ~ 255');
xlim([0, 260]);
ylabel('Number of Pixels');

end