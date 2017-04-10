function I_smooth = Smooth(I_input)
[M, N] = size(I_input);
I_smooth = zeros(M, N);
for i = 1:M
   for j = 2:N-1
      I_smooth(i,j) = (I_input(i,j) + I_input(i,j-1) + I_input(i,j+1))/3;
   end
end

% I_smooth = zeros(M, N);
% for i = 2:M-1
%    for j = 2:N-1
%       I_smth(i,j) = (I_input(i,j) + I_input(i,j-1) + I_input(i,j+1) + I_input(i-1,j) +I_input(i+1,j))/5;
%    end
% end

%%% First plot
I_orig = uint8(I_input);
I_smth = uint8(I_smooth);

figure,
subplot(1,2,1);
imshow(I_orig);
colormap(gray);
title('Original Image');

subplot(1,2,2);
imshow(I_smth);
colormap(gray)
title('Smoothed Image');
end