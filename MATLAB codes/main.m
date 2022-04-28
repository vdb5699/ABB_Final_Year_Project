%  inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 IP = "192.168.0.20";
 port = 1025;
 ph = photo_acquisition();
 res = "2560x720"

 im = ph.takePhoto(res,1);

%  circleDet = circle_detection(im,35);
% % circleDet = circle_detection(im,80);
%  cent = circleDet.detectCicle()
% 
%  colDet = colour_detection(cent,im);
%  caps = colDet.detectColour()

 emp = empty_slot_detection(im);
 empltySlots = emp.detectSlot(100, 5000);
%     imshow(im);
%   sender = send_data(IP, port);
%   [brown, red] = sender.sortCap(caps)
%   a = num2str(height(brown)+height(red))
%   sender.send(a)
%   pause(0.5)
%   for x = 1: height(brown)
%       prompt = "press enter to send x value"
%       %input(prompt)
%       b = num2str(brown(x,1))
%       sender.send(b);
%       pause(0.5)
%       prompt = "press enter to send y value"
%       %input(prompt)
%       c = num2str(brown(x,2))
%       sender.send(c);
%       pause(0.5)
%   end
% 
%   sender.send(num2str(red(1,1)))
%   pause(0.5)
%   sender.send(num2str(red(1,2)))
