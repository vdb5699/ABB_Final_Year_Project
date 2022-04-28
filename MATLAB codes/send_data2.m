classdef send_data2

    properties
        IP
        port
    end
    methods

        function obj = send_data2(IP, port)
            obj.IP = IP;
            obj.port = port;
            obj.flag = false
        end
        function send(obj, data)
            if flag == false
                t = tcpip('192.168.0.20', 1025, 'NetworkRole', 'client');
                fopen(t);
            end
            fwrite(t,data)
        end

        function [brown red] = sortCap(obj, caps)
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
