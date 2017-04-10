Overview Structure

1.	Algorithms and code files
Main.m
1.1	Histogram the Intensity Values of Each Image
Preprocessing.m 
Smooth.m
Histogram.m 
OTSUThreshold.m 
1.2	Connected Region Extraction
RasterScan.m
1.3	Computation of Blob Statistics
BlobStatistics.m 
Perimeter.m  
FindHole.m 

2.	Test images
2.1	reg3.jpg
2.2	reg4.jpg

3.	Output and plot
3.1	Smoothed image plot
3.2	Histogram plot
3.3	Threshold 
3.4	Abstracted image plot
3.5	Individual region plot along with perimeter
3.6	MBR and centroid plot
3.7	Parameter output txt



Notation:
a. The default format of input image is .jpg.
b. To check results and image plots, you just need to run Main. 
   Iterally, you can find all inforamtion which are required by pa3.
c. The output parameter could be found at BlobStatistic.txt.
d. The plot of individual region along with the indication of perimeter pixels,
   you can delete those indices in perimeter.m if you want.