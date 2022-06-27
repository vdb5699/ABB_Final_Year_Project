classdef photo_acquisition
    properties (Access = public)
       resolution
       brightness
       sharpness
       contrast
       saturation
       
       webcamID
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
            
            obj.defBrightness = 4;
            obj.brightness = 4;
            
            obj.defContrast = 4;
            obj.contrast = 4;
            
            obj.defSharpness = 0;
            obj.sharpness = 0;
            
            obj.defSaturation = 4;
            obj.saturation = 4;
            
            obj.webcamID = webcamID;
        end
        
        function image = manualImageAcq(obj)
            camera = webcam(obj.webcamID);
            camera.Resolution = obj.resolution;
            camera.Contrast = obj.contrast;
            camera.Saturation = obj.saturation;
            camera.Sharpness = obj.sharpness;
            
            
            [height, width, channels] = size(snapshot(camera));
            % preview(camera)

            prompt = "Press enter key to take photo";

            input(prompt);

            image = snapshot(camera);
            image = image(:,(width/2):width,:);
            return
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