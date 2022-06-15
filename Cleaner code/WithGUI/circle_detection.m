%% Circle detection
%in the actual code, I need to consider: flexible image directory, flexible
%diameter (or radius)
classdef circle_detection

    properties
        image
        diameter
        dispImage
    end

    methods
        function obj = circle_detection(im, dia)
            obj.image = im;
            obj.diameter = dia;

        end

        function centres = detectCicle(obj)
            radius = round(obj.diameter/2);
            %code for finding circles, change threshold if needed
            [centresTemp, radii] = imfindcircles(obj.image,[radius-10 radius+10],'Sensitivity',0.90,'EdgeThreshold', 0.01);
%             [centresTemp, radii] = imfindcircles(obj.image,[radius-10 radius+10],'Sensitivity',0.90,'EdgeThreshold', 0.05);

            centres = round(centresTemp)
            fig1 = figure('Name','Detected caps');
            imshow(obj.image)
            dispImage = viscircles(centres,radii);
            hold on;
            return
        end

        function changeImage(obj, newImg, newDia)
            obj.image= newImg;
            obj.diameter = newDia;
        end
    end
end
