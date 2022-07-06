classdef read_coord
    properties
        ID
    end
    
    methods
        function obj = read_coord(ID)
            obj.ID = ID
        end
        
        function coord = get_coord(obj)
            fileID = fopen(obj.ID, 'r')
            formatSpec = '%d %d';
            sizeA = [2 Inf]
            coord = fscanf(fileID,formatSpec,sizeA)
            fclose(fileID);
            coord = coord'
            return
        end
    end
end