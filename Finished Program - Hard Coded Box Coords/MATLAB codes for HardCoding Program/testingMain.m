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

