classdef convert_coord
    properties
        adjuster
    end
    
    methods
        function obj = convert_coord()
            obj.adjuster = adjust_centre();
        end

        function [x, y] = toRealLife(obj,pX,pY,bP,bR)
            rX = (pX/bP(1))*bR(1);
            rY = (pY/bP(2))*bR(2);
            coord = obj.adjuster.calculateCoord([rX, rY],bR);
            [x, y] = toRobCoord(obj,coord(1),coord(2));
            return
        end
        
        function [X, Y] = convertRed(obj, x, y)
            Xtemp = ((0.0491*x)-34.598)*10;
            Ytemp = ((-0.0496*y)+17.501)*10;

            [X, Y] = toRobCoord(obj, Xtemp, Ytemp);
            return
        end
        
        function [X, Y] = convertBrown(obj, x, y)
            Ytemp = ((-0.04*y)+14.236)*10;
            Xtemp = (x-730.53846)/24.91863)*10;
            
            [X, Y] = toRobCoord(obj, Xtemp, Ytemp);
            return             
        end
        function [X, Y] = toRobCoord(obj, x,y)
            X = -y;
            Y = -x;
            return 
        end
    end
end
