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

        function setIP(obj, IP)
            obj.IP = IP;
        end
        function setPort(obj, port)
            obj.port = port;
        end
    end


end