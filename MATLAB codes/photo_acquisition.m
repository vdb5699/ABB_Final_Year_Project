classdef photo_acquisition
    methods
        function img = takePhoto(resolution, camID)
            camera = webcam(camID);
            camera.Resolution = resolution;
            preview(camera)

            prompt = "Press enter key to take photo";

            input(prompt);

            img = snapshot(camera);
            return
        end
    end
end

