classdef photo_acquisition
    methods
        function img = takePhoto(obj, resolution, camID)
            camera = webcam(camID);
            camera.Resolution = resolution;
            [height width channels] = size(snapshot(camera));

            prompt = "Press enter key to take photo";

            input(prompt);

            img = snapshot(camera);
            img = img(:,1:(width/2),:);
            return
        end
    end
end

