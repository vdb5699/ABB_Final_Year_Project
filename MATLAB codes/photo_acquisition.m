camera = webcam()
preview(camera)
camera.Resolution = '4416x1242';

prompt = "Press any key to take photo";

x = input(prompt);

img = snapshot(camera);


