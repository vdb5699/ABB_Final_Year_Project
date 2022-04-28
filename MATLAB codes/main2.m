%  inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 IP = "192.168.0.20";
 port = 1025;
 ph = photo_acquisition();
 res = "2560x720"

 im = ph.takePhoto(res,1);

 circleDet = circle_detection(im,35);
% circleDet = circle_detection(im,80);
 cent = circleDet.detectCicle()

 colDet = colour_detection(cent,im);
 caps = colDet.detectColour()

 emp = empty_slot_detection(im);
 empltySlots = emp.detectSlot(100, 5000);
 imshow(im);
 sender = send_data(IP, port);
 [brown, red] = sender.sortCap(caps)
 a = num2str(height(brown)+height(red))
  sender.send(a)
  pause(0.5)
  for x = 1: height(brown)
      b = num2str(brown(x,1))
      sender.send(b);
      pause(0.5)
      c = num2str(brown(x,2))
      sender.send(c);
      pause(0.5)
  end
  
  prompt = "press enter to send red cap coordinates"
  input(prompt)

  for y = 1:height(red)
    sender.send(num2str(red(x,1)))
    pause(0.5)
    sender.send(num2str(red(x,2)))
    pause(0.5)
  end

  prompt = "press enter to send box coordinates"
  input(prompt)
  
   for y = 1:height(emptySlots)
    sender.send(num2str(empltySlots(x).centre(1)))
    pause(0.5)
    sender.send(num2str(empltySlots(x).centre(2)))
    pause(0.5)
  end

