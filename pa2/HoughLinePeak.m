function Position = HoughLinePeak(Hough, L_Num)

%L_Num = 6;
Position = zeros(L_Num, 2); % Store the location of peak points 
Hough_Sort = sort(Hough);
[Score, Angel_Val] = sort(Hough_Sort(end,:),'descend');
Angel_Val = Angel_Val(1:L_Num);
Position(:,1) = Angel_Val - 91; % 1st colomn for angle 
Score = Score(1:L_Num);
for i = 1:L_Num
   [xx1, yy1] = find(Hough == Score(i));
   if(yy1 == Angel_Val(i))
       Position(i,2) = xx1 - 1000; % 1st colomn for distance
   end
end

end