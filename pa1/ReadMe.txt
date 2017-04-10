Overview Structure

1.	Algorithms                                      Code files
1.1	Edge operators (Sobel and Roberts)              SobelEdge.m  RobertsEdge.m
1.2	Thresholding methods(OUST or Manual)            OTSUThreshold.m
1.3	Expansion                                       Expansion.m
1.4	Thinning method                                 Thining.m
1.5	Modified thinning method                        ThinningModified.m        (Extra Credit)

2.	Test images
2.1	Daisy.jpg
2.2	Sunflower.jpg

3.	Main MATLAB implementation
3.1	SobelEdgeMain.m
3.2	RobertsEdgeMain.m

Notation:
a. My discussion part is attached in the last part of Report.
b. The default format of input image is .jpg.
c. To check results and image plots, you just need to run SobelEdgeMain.m or RobertsEdgeMain.m which 
correspond to Sobel edge operator and Roberts edge operator.  
d. To change input image, please adjust code "A_origin = imread('Daisy.jpg');" in Main code.