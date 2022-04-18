%% color detection
classdef colour_detection
   properties
       caps
       centres
       image
   end
   
   methods
       function obj = colour_detection(cen, im)
           obj.centres = cen;
           obj.image = im;
       end

       function capList = detectColour(obj)
           for index = 1:height(obj.centres)
                xPos = obj.centres(index,1)
                yPos = obj.centres(index,2)
                plot(xPos,yPos,'ro','MarkerSize', 30);
                xStart = obj.centres(index,1)-2
                xEnd = obj.centres(index,1)+2
                
                yStart = obj.centres(index,2)-2;
                yEnd = obj.centres(index,2)+2;
                redCount = 0;
                goldCount = 0;
                neither = 0;
                for yCood = yStart:yEnd
                    for xCood = xStart:xEnd
                        [r,g,b] = obj.getColour(xCood,yCood);
                        if (r <= 255 && r >= 170) && (g <= 255 && g >= 160) && (b <= 210 && b >= 70)
                            goldCount = goldCount +1
                        elseif (r >= 205 && g <= 50 && b <= 50) || (r >= 240 && g >= 240 && b >= 240)
                            redCount = redCount +1
                        else 
                            neither = neither +1
                        end
                    end
                end
                if redCount == goldCount 
                    capList(index) = Cap([obj.centres(index,1) obj.centres(index,2)], "Unknown")
                elseif redCount > goldCount
                    capList(index) = Cap([obj.centres(index,1) obj.centres(index,2)], "Red")
                else 
                    capList(index) = Cap([obj.centres(index,1) obj.centres(index,2)], "Gold")
                end
                %for debugging
%                 goldCount
%                 redCount
%                 neither
           end
           return
       end

       function [R, G, B] = getColour(obj, x, y)
           R = obj.image(y, x, 1)
           G = obj.image(y, x, 2)
           B = obj.image(y, x, 3)
           return
       end
           
    
   end

end