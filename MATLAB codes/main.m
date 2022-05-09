%  inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 IP = "192.168.0.20";
 port = 1025;
 ph = photo_acquisition();
 res = "2560x720";
 bP = [1280 720];
 bR = [1227 690];
 flag = 1;
 im = ph.takePhoto(res,1);

 %diameter will be changed soon
 circleDet = circle_detection(im,65);
% circleDet = circle_detection(im,80);
 cent = circleDet.detectCicle()

 colDet = colour_detection(cent,im);
 caps = colDet.detectColour()

%  emp = empty_slot_detection(im);
%  empltySlots = emp.detectSlot(100, 5000);
%  imshow(im);
  sender = send_data(IP, port);
  tcp = tcpclient(IP,port);
  [brown, red] = sender.sortCap(caps)
  a = num2str(height(brown)+height(red))
  tcp.write(a)
  
  prompt = "press enter to send brown cap coordinates"
  input(prompt)
  converter = convert_coord();
  for x = 1: height(brown)
      flag = 0;
      tcp.write('B')
      [brown(x,1), brown(x,2)] = converter.convertBrown(brown(x,1),brown(x,2))
      prompt = "press enter to send x value"
      input(prompt)
      b = num2str(brown(x,1))
      tcp.write(b)
      pause(0.5)
      prompt = "press enter to send y value"
      input(prompt)
      c = num2str(brown(x,2))
      tcp.write(c)
      tcp.flush();
      pause(0.5)
      
      while flag == 0
        test = read(tcp)
        if char(test) == "Y"
            disp(char(test))
            flag = 1
        end
        pause(0.5)
      end
  end

  prompt = "press enter to send red cap coordinates"
  input(prompt)
  
  for y = 1:height(red)
    flag = 0
    tcp.write('R')
    [red(y,1), red(y,2)] = converter.convertRed(red(y,1),red(y,2))
    prompt = "press enter to send x value"
    input(prompt)
    tcp.write(num2str(red(y,1)))
    tcp.flush();
    pause(0.5)
    prompt = "press enter to send y value"
    input(prompt)
    tcp.write(num2str(red(y,2)))
    tcp.flush();
    pause(0.5)
    while flag == 0
        test = read(tcp)
        if char(test) == "Y"
            disp(char(test))
            flag = 1
        end
        pause(0.5)
     end
  end

%   prompt = "press enter to send box coordinates"
%   input(prompt)
%   
%   for z = 1:height(emptySlots)
%     tcp.write(num2str(empltySlots(z).centre(1)))
%     tcp.flush();
%     pause(0.5)
%     tcp.write(num2str(empltySlots(z).centre(2)))
%     tcp.flush();
%     pause(0.5)
%   end
% 
