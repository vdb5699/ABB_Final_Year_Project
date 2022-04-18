%% This class is for finding coordinate relative to centre of picture instead of measuring from top left (0,0) at centre
classdef adjust_centre
     properties
        centre
        picture_size
    end

    methods
        function obj = adjust_(centroid, picture_size)
            obj.centre = centroid;
            obj.picture_size = picture_size;
        end

        function newCoord = calculateCoord()
            newSizeX = round(obj.picture_size(1)/2);
            newSizeY = round(obj.picture_size(2)/2);

            newCoordX = centroid(1) - newSizeX;
            newCoordY = centroid(2) - newSizeY;

            newCoord = [newCoordX newCoordY];
            return
        end
    end
end