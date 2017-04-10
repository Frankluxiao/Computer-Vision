function I_hist = Histogram(I_input)
[M, N] = size(I_input);
I_hist = zeros(1,256);
for k = 0:255
    for i = 1:M
        for j = 1:N
            if(I_input(i,j) == k)
                I_hist(k+1) = I_hist(k+1) + 1; 
            end
        end
    end
end

figure,
subplot(1,2,1);
bar((0:255),I_hist,'b');
grid on;
title('My Intensity Histogram');
xlabel('0 ~ 255');
xlim([0, 260]);
ylabel('Number of Pixels');

subplot(1,2,2);
I_vect = reshape(I_input,[1,M*N]);
MATLAB_hist = histogram(I_vect,256);
grid on;
title('MATLAB Intensity Histogram');
xlabel('0 ~ 255');
xlim([0, 260]);
ylabel('Number of Pixels');