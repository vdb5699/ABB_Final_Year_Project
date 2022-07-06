classdef compare_data
    properties 
        MATData
        PyData
    end
   
    methods
        function obj = compare_data(mat, py)
            obj.MATData = mat
            obj.PyData = py
        end

        function newList = compare(obj)
            for x = 1:height(obj.MATData)
                for y = 1:height(obj.PyData)
                    %%%%COMPARE DATA, NEED TO DISCUSS HOW
                end
            end
        end

    end
end