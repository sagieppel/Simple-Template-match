
function [score,  y, x ]=Template_match_simple(Is,Itm)
% Find  Template Itm (binary) in canny or sobel of   image Is (GreyScale),
% return location of the best match and its score. 
%Use simple crosscorrelation between the templateItm and the canny edge image of image Is 
%show the image with the template marked on it
%INPUT:
%Is greyscale image in whihch template should be found
%Itm binary image of template 


%OUTPUT
%score Score of the best match
%x,y location of template Itm in image Is  (Location the edge (point [1,1]) of the template Itm in Is)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Intialize optional parameters and parameters and read image if was not given as input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all;
if (nargin<2) %if no image wa given as input
Itm=imread('itm.tif');
Is=imread('Is.tif');
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Im=double(Itm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Prepere system image found its edges using canny or sobel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------find edges canny or sobel of the system Is image--------------------------------------------------------------------------------------------------------

    Iedg=double(edge(Is,'canny'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Find template in the image (Main part) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------------------filter-----------------------------------------------------------------------------------------------------

Itr=imfilter(Iedg,Im,'same');%'same',0 % same mean the same size as Iedge zero mean the same size  as Is with the edges out side the picture counted as zero
%imtool(Itr,[]);
%---------------------------------------------------------------------------normalized according to template size (fraction of the template points that was found)------------------------------------------------------------------------------------------------
Itr=Itr./sqrt(sum(sum(Itm)));
%---------------------------------------------------------------------------find  the location best score all scores which are close enough to the best score
%imtool(Itr,[]);
mx=max(max(Itr)); %% find the best score of the bes match

[y,x]=find(Itr>=mx,  1, 'first'); % find the location first 1 best match of the template

score=zeros(size(y));
ss=size(Itm);
 

   score=Itr(y(1),x(1));
   y(1)=round(y(1)-ss(1)/2);% normalize the location of the cordinate to so it will point on the edge of the image and not its center
   x(1)=round(x(1)-ss(2)/2);

%-------------------------------------mark the best result on the system image (Optional Part demand addition function find2 and set2 given below)---------------------------------------------------------------------------
 k =find2(Itm,1);
 
 
mrk=set2(Is,k,255,y(1),x(1)); %paint the templa itm on the image Is
imshow(mrk);
  %pause();

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FUNCTIONS USED FOR MARKING TEMPLATE ON IMAGE (OPTIONAL)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%set2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%set2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%set2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%set2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [m2] = set2( m,k,v,y ,x )
% set value of  v in coordinates k of image m  with initial position x and y,
if nargin<4
    y=0;
    x=0;
end;
if x<0
    x=0;
end;
if y<0
    y=0;
end;
[a,b]=size(k);
m2=m;
for f=1:1:a
    m2(k(f,1)+y,k(f,2)+x)=v;
%m(6,6)=7;
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Find2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Find2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Find2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Find2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ p ] = find2(m, t )
%FIND2 find points in matrix m their value is above t return them as array

np=0;
[my,mx]=size(m);
for fy=1:1:my
    for fx=1:1:mx
        if (m(fy,fx)>=t)
           np=np+1;
           p(np,1)=fy;
            p(np,2)=fx;
        end;
    end
    
end
end
