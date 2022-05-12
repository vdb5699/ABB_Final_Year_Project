%% class for detecting empty slot in boxes. May need more tweaking depending on how the real life test goes.
classdef empty_slot_detection
    properties
        image
        caps
        centroids
        f
    end

    methods
        function obj = empty_slot_detection(im)
            obj.image = im;
            obj.f = figure("Name","Empty Slots");
        end

        function slotList = detectSlot(obj,brightness, areaSize)
            gray = rgb2gray(obj.image);
            imshow(gray)
            %turn gray image into binary image (brightness > 100 will be
            %white and <= 100 will be black. The value would differ
            %depending on brightness of image.
            bIm = gray < brightness;
            imshow(bIm);
            hold on;
            %clear out small areas for better and easier detection
            bIm = bwareaopen(imfill(bIm,'holes'),areaSize);
%             imshow(bIm);
            [labIm numOb] = bwlabel(bIm);
            blob = regionprops(labIm,'Perimeter','Area', 'Centroid');

            boundaries = bwboundaries(bIm);
            ar = [blob.Area];
            centr = [blob.Centroid];
            peri = [blob.Perimeter];
            circul = peri .^2./ (4* pi * ar)
            brightness
            slotList = eliminateCaps(obj,ar,circul,centr, boundaries);
%             d = drawline;
%             pos = d.Position;
%             diffPos = diff(pos);
%             Width = hypot(diffPos(1),diffPos(2))
%             d = drawline;
%             pos = d.Position;
%             diffPos = diff(pos);
%             height = hypot(diffPos(1),diffPos(2))
             if width(slotList) ~= 2 && brightness > 80
                slotList = detectSlot(obj, brightness-2, areaSize);
             end
            return
        end

        function compList = eliminateCaps(obj, areas, cir, cen, boundaries)
            counter = 1;
            sample = EmptySlot([0 0]);
            compList = [sample];
            for objectNumber = 1: length(areas)
                bound = boundaries{objectNumber};
                plot(bound(:,2),bound(:,1),'r',LineWidth=3);
                   if ((cir(objectNumber) > 1.2) && (cir(objectNumber) < 2.5) && areas(objectNumber) < 130000) 
                    
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

