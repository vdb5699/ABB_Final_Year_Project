%% class for detecting empty slot in boxes. May need more tweaking depending on how the real life test goes.
classdef empty_slot_detection
    properties
        image
        caps
        centroids
    end

    methods
        function obj = empty_slot_detection(im)
            obj.image = im;
        end

        function slotList = detectSlot(obj,brightness, areaSize)
            gray = rgb2gray(obj.image);
            %turn gray image into binary image (brightness > 100 will be
            %white and <= 100 will be black. The value would differ
            %depending on brightness of image.
            bIm = gray > brightness;
            fig2 = figure('Name','Empty slots')
            imshow(obj.image)
            hold on;
            %clear out small areas for better and easier detection
            bIm = bwareaopen(bIm,areaSize);
            [labIm numOb] = bwlabel(bIm);
            blob = regionprops(labIm,'Perimeter','Area', 'Centroid');

            boundaries = bwboundaries(bIm);
            ar = [blob.Area];
            centr = [blob.Centroid];
            peri = [blob.Perimeter];
            circul = peri .^2./ (4* pi * ar);
            slotList = eliminateCaps(obj,ar,circul,centr, boundaries);
            return
        end

        function compList = eliminateCaps(obj, areas, cir, cen, boundaries)
            counter = 1;
            sample = EmptySlot([0 0]);
            compList = [sample];
            for objectNumber = 1: length(areas)
                bound = boundaries{objectNumber};

                if ((cir(objectNumber) > 1.3) && (cir(objectNumber) < 2.0)) 
                    plot(bound(:,2),bound(:,1),'r',LineWidth=3);
                    currentCen = [cen((objectNumber*2)-1) cen(objectNumber*2)]
                    plot(currentCen(1),currentCen(2),'ro','MarkerSize', 30);
                    compList(counter) = EmptySlot([cen((objectNumber*2)-1) cen(objectNumber*2)]) 

                    counter = counter+1;
                end
            end
            return
        end
    end
end
