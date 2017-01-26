Simple Template match. 
Find template (Itm) in edge image of image (Is). Matlab code.
Return the location of the template in the image and the score of the match in this point. Mark the template location on the image the image (Is). 
INPUT: 
1) Greyscale image where the template should be found (Is). 
2)The template Binary image (Itm). 
Method: 
Use simple template match (Cross correlation) between the template (Itm) and the canny edge image of the grayscale image (Is). 
The size of the template (Itm) and the size of object i to be recognised n the image (Is) must be the same. 
For the similar function that recognise the template in image even if the object dont feet the template size see “Simple template match with variable image to template size ratio
