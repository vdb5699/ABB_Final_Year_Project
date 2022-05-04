IP = "192.168.0.20";
port = 5000;

data1 = '3';

data2 = ['200' '400']

data3 = ['600' '700']

data4 = ['800' '900']

sender = send_data(IP, port)

prompt = 'enter to send data1';
input(prompt);

sender.send(data1);

prompt = 'enter to send data2(1)';
input(prompt);

sender.send(data2(1));

prompt = 'enter to send data2(2)';
input(prompt);

sender.send(data2(2));

prompt = 'enter to send data3(1)';
input(prompt);

sender.send(data3(1));

prompt = 'enter to send data3(2)';
input(prompt);

sender.send(data3(2));

prompt = 'enter to send data4(1)';
input(prompt);

sender.send(data4(1));

prompt = 'enter to send data4(2)';
input(prompt);

sender.send(data4(2));
