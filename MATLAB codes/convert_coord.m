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

        function [X, Y] = toRobCoord(obj, x,y)
            X = -y;
            Y = -x;
            return 
        end
    end
end
