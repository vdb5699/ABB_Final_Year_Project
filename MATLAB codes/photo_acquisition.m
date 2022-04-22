classdef photo_acquisition
    methods
        function img = takePhoto(resolution, camID)
            camera = webcam(camID);
            camera.Resolution = "4416x1242";
            preview(camera)

            prompt = "Press enter key to take photo";

            input(prompt);

            img = snapshot(camera);
            return
        end
    end
end

