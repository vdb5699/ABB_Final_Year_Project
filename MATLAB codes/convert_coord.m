classdef convert_coord
    properties
        adjuster
    end
    
    methods
        function obj = convert_coord()
            obj.adjuster = adjust_centre();
        end

        function newCoord = toRealLife(obj,pX,pY,bP,bR)
            rX = (pX/bP(1))*bR(1);
            rY = (pY/bP(2))*bR(2);
            newCoord = obj.adjuster.calculateCoord([rX, rY],bR);
            return
        end
    end
end