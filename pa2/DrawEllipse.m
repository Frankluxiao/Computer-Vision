function DrawEllipse(I_orig, Best_ellipse, K_Num)
% M= size(I_orig,1);
% M= size(I_orig,1);
X0 = Best_ellipse(1:K_Num,1); 
Y0 = Best_ellipse(1:K_Num,2); 
A = Best_ellipse(1:K_Num,3);
B = Best_ellipse(1:K_Num,4);
t = linspace(0,2*pi);

figure,
image(I_orig);
title('Ellipse Reconstrction on Original Image');
color map('gray');
hold on;
for i = 1:K_Num
plot(X0(i) + A(i)*cos(t),Y0(i) + B(i)*sin(t),'LineWidth',2);
hold on;
grid on;
end
hold off;