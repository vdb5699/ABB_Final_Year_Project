%% This class is for finding coordinate relative to centre of picture instead of measuring from top left (0,0) at centre
classdef adjust_centre

    methods
        function newCoord = calculateCoord(~, centroid, picture_size)
            newSizeX = round(picture_size(1)/2);
            newSizeY = round(picture_size(2)/2);

            newCoordX = centroid(1) - newSizeX;
            newCoordY = centroid(2) - newSizeY;

            newCoord = [newCoordX newCoordY];
            return
        end
    end
end