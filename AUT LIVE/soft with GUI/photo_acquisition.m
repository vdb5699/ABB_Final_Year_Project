classdef photo_acquisition
    properties (Access = public)
       resolution
       brightness
       sharpness
       contrast
       saturation
       
       webcamID

       %%sat 8
       %shar 8
       %bright 8
       %cont 3
       %resolution 2k
       
    end
    
    properties (Access = private)
       defResolution
       defBrightness
       defSharpness
       defContrast
       defSaturation
    end
    
    methods
        function obj = photo_acquisition(defResolution, webcamID)
            obj.defResolution = defResolution;
            obj.resolution = defResolution;
            
            obj.defBrightness = 0;
            obj.brightness = 0;
            
            obj.defContrast = 0;
            obj.contrast = 0;
            
            obj.defSharpness = 8;
            obj.sharpness = 8;
            
            obj.defSaturation = 8;
            obj.saturation = 8;
            
            obj.webcamID = webcamID;

            camera = webcam(obj.webcamID);
            camera.Brightness = obj.brightness;
            camera.Resolution = obj.resolution;
            camera.Contrast = obj.contrast;
            camera.Saturation = obj.saturation;
            camera.Sharpness = obj.sharpness;
        end
        
        function image = manualImageAcq(obj)
            camera = webcam(obj.webcamID);
            camera.Brightness = obj.brightness;
            camera.Resolution = obj.resolution;
            camera.Contrast = obj.contrast;
            camera.Saturation = obj.saturation;
            camera.Sharpness = obj.sharpness;
            camera.Gamma = 1;
            
            
            [height, width, channels] = size(snapshot(camera));
            % preview(camera)

%             prompt = "Press enter key to take photo";
% 
%             input(prompt);

            image = snapshot(camera);
            image = image(:,(width/2):width,:);
            return
        end

        function image = tempImage(obj, bright, res, cont, sat, shar)
            camera = webcam(obj.webcamID);
            camera.Brightness = bright;
            camera.Resolution = res;
            camera.Contrast = cont;
            camera.Saturation = sat;
            camera.Sharpness = shar;
            camera.Gamma = 1;
            
            
            [height, width, channels] = size(snapshot(camera));
            % preview(camera)

%             prompt = "Press enter key to take photo";
% 
%             input(prompt);

            image = snapshot(camera);
            image = image(:,(width/2):width,:);


        end
        
        function obj = setVars(obj, newRes, newBri,newCont, newSat, newShar)
            obj.brightness = newBri;
            obj.resolution = newRes;
            obj.contrast = newCont;
            obj.saturation = newSat;
            obj.sharpness = newShar;
            return
        end
        
        function bri = getDefBri(obj)
            bri = obj.defBrightness;
            return
        end
        
        function res = getDefRes(obj)
           res = obj.defResolution;
           return
        end
        
        function cont = getDefCont(obj)
            cont = obj.defContrast;
            return
        end
        
        function shar = getDefShar(obj)
            shar = obj.defSharpness;
            return
        end
        
        function sat = getDefSat(obj)
            sat = obj.defSaturation;
            return
        end
        
    end
end