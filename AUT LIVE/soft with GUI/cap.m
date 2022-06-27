classdef cap
   properties
       centreCoord
       colour
   end
    
   methods
       function obj = cap(cent, colour)
          obj.centreCoord = cent;
          obj.colour = colour;
       end
   end
    
end