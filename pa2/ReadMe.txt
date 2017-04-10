Overview Structure

1.Algorithms and code files
1.1Hough transform for Line detection 
    MainLine.m 
    RobertsEdge.m 
    OTSUThreshold.m  
    HoughTransfromLine.m 
    HoughLinePeak.m
1.2 Hough trandform for Ellipse detection
    MainEllipse.m 
    RobertsEdge.m 
    OTSUThreshold.m  
    HoughTransfromEllipse.m 
    DrawEllipse.m

2.Test images
    line1.jpg
    ellipse1.jpg


Notation:
a. The default format of input image is .jpg.
b. To check results and image plots, you just need to run MainLine.m or MainEllipse.m which 
correspond to Lines detection and Ellipses detection.  
c. The output parameter of lines is 'Position'. The first column is lines' angel, the second 
column is lines' distance.
d. The output parameter of ellipses is 'Best_ellipse'. The first two columns correspond to 
ellipses' center location x0, y0, column 3 and 4 correspond to ellipses' a and b, the last 
column is the orientation of ellipses. 