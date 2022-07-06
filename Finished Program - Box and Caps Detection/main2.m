IP = "192.168.0.20";
port = 1025; 

bP = [1280 720];
 bR = [1227 690];
pp = [375 334];

a = convert_coord()
[x, y] = a.toRealLife(pp(1), pp(2), bP, bR)

%%
intri = cameraIntrinsics([536.24 536.18], [638.09 342.0275], [1280 720],"RadialDistortion",[-0.0486 0.0194]);
k1 = -0.0486
k2 = 0.0194
% k3 = -0.0081
radialDist = [k1 k2];
t = intri.IntrinsicMatrix';
camP = cameraParameters('IntrinsicMatrix',intri.IntrinsicMatrix, 'RadialDistortion',radialDist, TangentialDistortion=[-0.0002 -0.0001]);

res = "2560x720";
a = photo_acquisition()
I = a.takePhoto(res,1);
[J or] = undistortImage(I,camP,OutputView="full");
b = figure;
imshow(J);
c = figure;
imshow(I);

%%
Z = (536.24*0.029)/(66)
X = ((358-638.09)*Z)/536.24
Y = ((477 - 342.0275)*Z)/536.18

%%
conv = convert_coord();
[x, y] = conv.convertBox(1001, 485)

%%
b = photo_acquisition();
res = "2560x720";
img = b.takePhoto(res,1);
figue = figure
imshow(img)
hold on
% d = drawline;
% pos = d.Position;
% diffPos = diff(pos);
% diameter = hypot(diffPos(1),diffPos(2))
emp = empty_slot_detection(img);
emptySlots = emp.detectSlot(100, 70000)
% fig = figure;
% imshow(img);
% hold on 
% for x = 1 : width(emptySlots)
%     plot(emptySlots(x).centre(1),emptySlots(x).centre(2),'ro','MarkerSize', 15);
%     plot(emptySlots(x).centre(1)+70,emptySlots(x).centre(2),'ro','MarkerSize', 40);
%     plot(emptySlots(x).centre(1)-70,emptySlots(x).centre(2),'ro','MarkerSize', 40);
%     plot(emptySlots(x).centre(1)+70,emptySlots(x).centre(2)+140,'ro','MarkerSize', 40);
%     plot(emptySlots(x).centre(1)-70,emptySlots(x).centre(2)+140,'ro','MarkerSize', 40);    
%     plot(emptySlots(x).centre(1)+70,emptySlots(x).centre(2)-140,'ro','MarkerSize', 40);
%     plot(emptySlots(x).centre(1)-70,emptySlots(x).centre(2)-140,'ro','MarkerSize', 40);    
% end
% 

