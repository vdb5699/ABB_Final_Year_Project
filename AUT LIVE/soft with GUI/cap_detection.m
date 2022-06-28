classdef cap_detection
    properties
        sensitivity
        edgethresh
        diameter

        defSens
        defThre
        defDia
    end

    methods
        function obj = cap_detection(defSens, defThresh, defDia)
            obj.sensitivity = defSens;
            obj.edgethresh = defThresh;
            obj.diameter = defDia;

            obj.defDia = defDia;
            obj.defSens = defSens;
            obj.defThre = defThresh;
        end

        function caps = automaticDetection(obj, image)
            radius = round(obj.diameter/2);
            [centres, radii] = imfindcircles(image, [radius-8 radius+8], 'Sensitivity', obj.sensitivity, 'EdgeThreshold', obj.edgethresh);
            [centres2, radii2] = imfindcircles(image, [radius-8 radius+8], "EdgeThreshold", obj.edgethresh, Sensitivity=obj.sensitivity, ObjectPolarity="dark");
            centres = [centres; centres2];
            radii = [radii; radii2]
            caps = round(centres);
%             fig = figure("Name", "detected caps", Visible="off");
            fig = figure("Name", "detected caps");
            imshow(image);
            viscircles(centres, radii);
            hold on 
            for i = 1:height(caps)
                str = num2str(caps(i,1)) + ", "+ num2str(caps(i,2));
                text(centres(i,1), centres(i,2), str, 'color', 'cyan');
            end
            saveas(fig,"detectedCaps","png")
            return
        end

        function newDia = obtainDiameter(obj, image)
            flag = 0;
            while flag == 0
                try
                    fig = figure("Name", "draw a line to determine the diameter of caps");
                    imshow(image)
                    hold on
                    d = drawline;
                    pos = d.Position;
                catch
                    continue
                end
                flag = 1;
            end
            diffpos = diff(pos);
            newDia = hypot(diffpos(1), diffpos(2))
            close(fig)
            return
        end

        function obj = setVariables(obj, newSens, newThresh)
            obj.sensitivity = newSens;
            obj.edgethresh = newThresh;
        end

        function obj = setDia(obj, newDia)
            obj.diameter = newDia;
        end

        function obj = restoreSens(obj)
            obj.edgethresh = obj.defThre;
            obj.sensitivity = obj.defSens;
        end
    end
end