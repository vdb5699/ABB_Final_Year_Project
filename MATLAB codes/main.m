 inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 im = readimage(inputImage,1);

 circleDet = circle_detection(im,66);
% circleDet = circle_detection(im,80);
 cent = circleDet.detectCicle()

 colDet = colour_detection(cent,im);
 caps = colDet.detectColour()

 emp = empty_slot_detection(im);
 empltySlots = emp.detectSlot(100, 5000);