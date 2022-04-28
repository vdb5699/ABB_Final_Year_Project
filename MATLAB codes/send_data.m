classdef send_data

    properties
        IP
        port
    end
    methods

        function obj = send_data(IP, port)
            obj.IP = IP;
            obj.port = port;
        end
        function send(obj, data)
            tcp = tcpclient(obj.IP,obj.port)
            write(tcp,data)
            clear tcp
        end

        function [brown red] = sortCap(obj, caps)
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
                    elseif caps(x).colour == "Gold"
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

        function setIP(obj, IP)
            obj.IP = IP;
        end
        function setPort(obj, port)
            obj.port = port;
        end
    end


end
