 inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jpg"]);
 im = readimage(inputImage,1);
 
 gray = rgb2gray(im);
            %turn gray image into binary image (brightness > 100 will be
            %white and <= 100 will be black. The value would differ
            %depending on brightness of image.
 bIm = gray >= 10;

 imshow(bIm);
            %clear out small areas for better and easier detection
 bIm = bwareaopen(bIm,7000);
 bIm = bIm ~= 1;
 bIm = bwareaopen(bIm,500);
 imshow(im);
 hold on
 [labIm numOb] = bwlabel(bIm);
 blob = regionprops(labIm,'Perimeter','Area', 'Centroid');

 boundaries = bwboundaries(bIm);
 ar = [blob.Area];
 centr = [blob.Centroid];
 peri = [blob.Perimeter];
 circul = peri .^2./ (4* pi * ar);
 for a = 1: length(circul)
    if (circul(a) < 1.3)
       currentCen = [centr((a*2)-1) centr(a*2)]
       plot(currentCen(1),currentCen(2),'ro','MarkerSize', 30);
    end

 end