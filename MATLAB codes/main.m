%  inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 IP = "172.16.44.240";
 port = 34322;
 ph = photo_acquisition();
 res = "2560x720"
 im = ph.takePhoto(res,1);

 circleDet = circle_detection(im,36);
% circleDet = circle_detection(im,80);
 cent = circleDet.detectCicle()

 colDet = colour_detection(cent,im);
 caps = colDet.detectColour()

%  emp = empty_slot_detection(im);
%  empltySlots = emp.detectSlot(100, 5000);

  sender = send_data(IP, port);
  [red, brown] = sender.sortCap(caps);
  sender.send(brown);
  sender.send(red);
