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
            % inputImage = imageDatastore('C:\Uni stuff\Project\Model image', 'FileExtensions', [".jfif"]);
            % im = readimage(inputImage,1);
        end

        function centres = detectCicle(obj)
%             imshow(obj.image)
%             d = drawline;
%             pos = d.Position;
%             diffPos = diff(pos);
%             obj.diameter = hypot(diffPos(1),diffPos(2))
            % diameter = 66;
            radius = round(obj.diameter/2);
            [centresTemp, radii] = imfindcircles(obj.image,[radius-10 radius+10],'Sensitivity',0.90,'EdgeThreshold', 0.01);
%             [centres2, radiii] = imfindcircles(obj.image,[radius-10 radius+10],'Sensitivity',0.90, 'ObjectPolarity','dark','EdgeThreshold', 0.2);
%             centresTemp = [centresTemp; centres2]
%             radii = [radii; radiii]
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
