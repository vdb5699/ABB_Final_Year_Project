classdef convert_coord
    properties
        adjuster
    end
    
    methods
        function obj = convert_coord()
            obj.adjuster = adjust_centre();
        end
        
        %% This function uses boundary method, it is not really used
        function [x, y] = toRealLife(obj,pX,pY,bP,bR)
            rX = (pX/bP(1))*bR(1);
            rY = (pY/bP(2))*bR(2);
            coord = obj.adjuster.calculateCoord([rX, rY],bR);
            [x, y] = toRobCoord(obj,coord(1),coord(2));
            return
        end
        %% Polynomial methods
        function [X, Y] = convertRed(obj, x, y)
            Xtemp = ((0.0491*x)-34.598)*10;
            Ytemp = ((-0.0496*y)+17.501)*10;

            [X, Y] = toRobCoord(obj, Xtemp, Ytemp);
            return
        end
        
        function [X, Y] = convertBrown(obj, x, y)
            Ytemp = ((-0.04*y)+14.236)*10;
            Xtemp = ((x-730.53846)/24.91863)*10;
            
            [X, Y] = toRobCoord(obj, Xtemp, Ytemp);
            return             
        end

        function [X, Y] = convertBox(obj, x, y)
            X = ((0.0776*x) - 52.877)*10
            Y = ((-0.0782*y) + 28.048)*10
            return
        end

        function [X, Y] = toRobCoord(obj, x,y)
            X = y;
            Y = -x;
            %this code was written for error reduction, uncomment if needed    
%             if Y < 0
%                 Y = Y - (0.000127*Y*Y);
%             elseif Y > 0 
%                 Y = Y + (0.000127*Y*Y);
%             end
            return 
        end
%% Used for separating brown and red caps 
        function [brown, red] = sortCap(obj, caps)
            if width(caps) == 0
                brown = []
                red = []
                return

            else
                redCapCount = 0;
                brownCapCount = 0;
                for x = 1:width(caps)
                    if caps(x).colour == "Red"
                        redCapCount = redCapCount+1;
                        red(redCapCount,1) = caps(x).centre(1)
                        red(redCapCount,2) = caps(x).centre(2)
                    elseif caps(x).colour == "Brown"
                        brownCapCount = brownCapCount+1;
                        brown(brownCapCount,1) = caps(x).centre(1)
                        brown(brownCapCount,2) = caps(x).centre(2)
                    else
                        
                    end
                end

                if redCapCount == 0
                    red = []
                end
                if brownCapCount == 0
                    brown = []
                end
                return
            end
        end



    end
end
