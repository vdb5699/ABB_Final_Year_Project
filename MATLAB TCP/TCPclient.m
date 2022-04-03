%% Connecting to server and port 1025
t = tcpip('192.168.0.20', 1025, 'NetworkRole', 'client');
fopen(t);

%% Writing data to server
data = 1:4; %test data
fwrite(t,data)