%% details of empty slots

classdef EmptySlot
    properties
        centre
        relative_centroid
    end

    methods
        function obj = EmptySlot(centroid)
            obj.centre = centroid;
        end
    end
end