%  inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 IP = "192.168.0.20";
 port = 1025;
 ph = photo_acquisition();
 res = "2560x720";
 flag = 1;
 im = ph.takePhoto(res,1);

 %diameter will be changed soon
 circleDet = circle_detection(im,65);
 %circleDet = circle_detection(im,80);
 cent = circleDet.detectCicle()

 colDet = colour_detection(cent,im);
 caps = colDet.detectColour()

%  emp = empty_slot_detection(im);
%  empltySlots = emp.detectSlot(100, 5000);
%  imshow(im);
  sender = send_data(IP, port);
  tcp = tcpclient(IP,port);
  [brown, red] = sender.sortCap(caps);
  a = num2str(height(brown)+height(red));
  tcp.write(a)
  tcp.flush()
  pause(0.5)
  disp("sending number of object")
  tcp.write(num2str(height(brown)));
  tcp.flush()
  pause(0.5)
  tcp.write(num2str(height(red)));
  tcp.flush()
  pause(0.5)
  converter = convert_coord();

  disp("Sending brown cap coordinate")
  for x = 1: height(brown)
      flag = 0;
      tcp.write('B')
      tcp.flush();
      pause(3)
      [brown(x,1), brown(x,2)] = converter.convertBrown(brown(x,1),brown(x,2));
      xcoord = num2str(brown(x,1))
      msg = ['sending x value: ',xcoord]
      disp(msg);
      tcp.write(a);
      tcp.flush();
      pause(3);
        
      ycoord = num2str(brown(x,2))
      msg = ['sending y value: ',ycoord]
      disp(msg);
      tcp.write(b);
      tcp.flush();
      pause(3);
      
      disp("waiting for robot to place the bottle");
      while flag == 0
        test = read(tcp);
        if char(test) == "Y"
            disp("data received, moving on to next coordinate");
            flag = 1
        end
        pause(0.5)
      end
  end

  disp("Moving on to red bottles")
  
  for y = 1:height(red)
    flag = 0;
    tcp.write('R')
    tcp.flush()
    pause(3)
    [red(y,1), red(y,2)] = converter.convertRed(red(y,1),red(y,2))

    xcoord = num2str(red(y,1))
    msg = ['sending x value: ',xcoord]
    disp(msg);
    tcp.write(c)
    tcp.flush();
    pause(3)

    ycoord = num2str(red(y,2))
    msg = ['sending y value: ',ycoord]
    disp(msg);
    tcp.write(d)
    tcp.flush();
    pause(3)

    disp("waiting for robot to place the bottle");
    while flag == 0
        test = read(tcp);
        if char(test) == "Y" && y < height(red)
            disp("data received, moving on")
            flag = 1;
        else
            disp("That was the last coordinate, ending the program :)")
            flag = 1;
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
