%% cap class
classdef Cap
    properties
        centre
        colour
    end

    methods
        function obj = Cap(cen, col)
            obj.centre = cen;
            obj.colour = col;
        end
    end
end