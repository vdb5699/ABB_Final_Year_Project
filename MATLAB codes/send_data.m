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

        function [brown red] = sortCap(caps)
            if heihgt(caps) == 0
                brown = []
                red = []
                return

            else
                redCapCount = 0;
                brownCapCount = 0;
                for x = 1:height(caps)
                    if caps(x).colour == "Red"
                        redCapCount = redCapCount+1;
                        red(redCapCount) = caps(x).centre
                    elseif caps(x).colour == "Brown"
                        brownCapCount = brownCapCount+1;
                        brown(brownCapCount) = caps(x).centre
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
