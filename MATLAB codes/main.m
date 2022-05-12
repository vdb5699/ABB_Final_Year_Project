%  inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
 IP = "192.168.0.20";
 port = 1025;
 ph = photo_acquisition();
 res = "2560x720";
 flag = 0;
 tcp = tcpclient(IP,port);
 converter = convert_coord();
tcp.write('Connected')
tcp.flush();
 while flag == 0
        test = read(tcp);
        if char(test) == "B"
            disp("data received, Taking photo of the boxes");
            flag = 1;
        end
        pause(0.5)
 end
 flag = 0;
 im = ph.takePhoto(res,1);
 
 tcp.write("Y");
 tcp.flush();

 emp = empty_slot_detection(im);
 emptySlots = emp.detectSlot(116, 90000);
 width(emptySlots)
 fig = figure;
 imshow(im);
 hold on;
 for x = 1 : width(emptySlots)
    plot(emptySlots(x).centre(1),emptySlots(x).centre(2),'ro','MarkerSize', 15);
    plot(emptySlots(x).centre(1)+70,emptySlots(x).centre(2),'ro','MarkerSize', 40);
    plot(emptySlots(x).centre(1)-70,emptySlots(x).centre(2),'ro','MarkerSize', 40);
    plot(emptySlots(x).centre(1)+70,emptySlots(x).centre(2)+140,'ro','MarkerSize', 40);
    plot(emptySlots(x).centre(1)-70,emptySlots(x).centre(2)+140,'ro','MarkerSize', 40);    
    plot(emptySlots(x).centre(1)+70,emptySlots(x).centre(2)-140,'ro','MarkerSize', 40);
    plot(emptySlots(x).centre(1)-70,emptySlots(x).centre(2)-140,'ro','MarkerSize', 40);    
    
    [slots(x,1), slots(x,2)] = converter.convertBox((emptySlots(x).centre(1)-70), (emptySlots(x).centre(2)+140));
    [slots(x,3), slots(x,4)] = converter.convertBox((emptySlots(x).centre(1)+70), (emptySlots(x).centre(2)+140));
    [slots(x,5), slots(x,6)] = converter.convertBox((emptySlots(x).centre(1)-70), emptySlots(x).centre(2));
    [slots(x,7), slots(x,8)] = converter.convertBox((emptySlots(x).centre(1)+70), emptySlots(x).centre(2));
    [slots(x,9), slots(x,10)] = converter.convertBox((emptySlots(x).centre(1)-70), (emptySlots(x).centre(2)-140));
    [slots(x,11), slots(x,12)] = converter.convertBox((emptySlots(x).centre(1)+70), (emptySlots(x).centre(2)-140)); 

end



 while flag == 0
        test = read(tcp);
        if char(test) == "C"
            disp("data received,Taking photo of bottles");
            flag = 1
        end
        pause(0.5)
 end

 flag = 0;
 im = ph.takePhoto(res,1);
 
 tcp.write("Y");
 tcp.flush();

 %diameter will be changed soon
 circleDet = circle_detection(im,65);
 %circleDet = circle_detection(im,80);
 cent = circleDet.detectCicle()

 colDet = colour_detection(cent,im);
 caps = colDet.detectColour()


%  imshow(im);
  sender = send_data(IP, port);
  
  [brown, red] = sender.sortCap(caps);
  numbObj = num2str(height(brown)+height(red));
  tcp.write(numbObj)
  tcp.flush()
  pause(0.5)
  disp("sending number of object")
  tcp.write(num2str(height(brown)));
  tcp.flush()
  pause(0.5)
  tcp.write(num2str(height(red)));
  tcp.flush()
  pause(0.5)

  disp("Sending brown cap coordinate")
  for x = 1: height(brown)
      flag = 0;
      tcp.write('B')
      tcp.flush()
      pause(2.5)
      [brown(x,1), brown(x,2)] = converter.convertBrown(brown(x,1),brown(x,2));
      xcoord = num2str(brown(x,1));
      msg = ['sending x value: ',xcoord];
      disp(msg);
      tcp.write(xcoord)
      tcp.flush()
      pause(2.5)
        
      ycoord = num2str(brown(x,2));
      msg = ['sending y value: ',ycoord];
      disp(msg);
      tcp.write(ycoord)
      tcp.flush()
      pause(2.5)
      
      xBox = slots(1,(x*2)-1);
      xcoord = num2str(xBox);
      msg = ['sending x value (Box): ',xcoord];
      disp(msg);
      tcp.write(xcoord)
      tcp.flush()
      pause(2.5)
        
      yBox = slots(1,x*2);
      ycoord = num2str(yBox);
      msg = ['sending y value (Box): ',ycoord];
      disp(msg);
      tcp.write(ycoord)
      tcp.flush()
      pause(2.5)


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
    pause(2.5)
    [red(y,1), red(y,2)] = converter.convertRed(red(y,1),red(y,2))

    xcoord = num2str(red(y,1));
    msg = ['sending x value: ',xcoord];
    disp(msg);
    tcp.write(xcoord)
    tcp.flush()
    pause(2.5)

    ycoord = num2str(red(y,2));
    msg = ['sending y value: ',ycoord];
    disp(msg);
    tcp.write(ycoord)
    tcp.flush()
    pause(2.5)

    xBox = slots(2,(y*2)-1);
    xcoord = num2str(xBox);
    msg = ['sending x value (Box): ',xcoord];
    disp(msg);
    tcp.write(xcoord)
    tcp.flush()
    pause(2.5)
        
    yBox = slots(2,y*2);
    ycoord = num2str(yBox);
    msg = ['sending y value (Box): ',ycoord];
    disp(msg);
    tcp.write(ycoord)
    tcp.flush()
    pause(2.5)



    disp("waiting for robot to place the bottle");
    while flag == 0
        test = read(tcp);
        if char(test) == "Y" && y < height(red)
            disp("data received, moving on")
            flag = 1;
        elseif char(test) == "Y"
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
