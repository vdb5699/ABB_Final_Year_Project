MODULE Module1
    CONST robtarget Home:=[[1018.612159322,0,1417.5],[0.5,0,0.866025404,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !CONST robtarget CameraTest:=[[918.365275369,0,1028.483059473],[-0.000000024,-0.00000003,1,0],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget CameraPos:=[[888.647981627,-3.101979233,1192.532782595],[0.004363108,0.006108556,-0.999971823,-0.000041884],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget GripperInitPos:=[[888.647981627+154,-3.101979233-15.5,1192.532782595],[0.004363108,0.006108556,-0.999971823,-0.000041884],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ObjAbovePos:=[[888.647981627+154+50,-3.101979233-15.5+132,1192.532782595],[0.004363108,0.006108556,-0.999971823,-0.000041884],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget Obj:=[[993.065,-342.407,1132.53],[0.00436311,0.00610856,-0.999972,-4.1884E-05],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR	socketdev serverSocket;
	VAR	socketdev clientSocket;
	VAR	string data;
    VAR socketdev server;
    VAR socketdev client;
    VAR string num_objects;
    VAR string x_coordinate;
    VAR string y_coordinate;
    VAR num num_objs;
    VAR num X;
    VAR num Y;
    VAR num sum;
    VAR bool objects;
    VAR bool posx;
    VAR bool posy;
    VAR string dummy;
    
    PROC main()
!        tcpip;
!        MoveL Home,v150,fine,tool0\WObj:=wobj0;
        MoveL CameraPos,v100,fine,tool0\WObj:=wobj0;
!        MoveL GripperInitPos,v100,fine,tool0\WObj:=wobj0;
!        MoveL ObjAbovePos,v100,fine,tool0\WObj:=wobj0;
!        open_gripper;
!        close_gripper;
!        MoveL CameraPos,v100,fine,tool0\WObj:=wobj0;

!        WHILE sum<num_objs DO
!            receiveData;
!            moveToObj;
!            SocketSend client,\Str :="Y";
!            sum:=sum+1;
!        ENDWHILE
!        SocketClose server;
    ENDPROC
    
    PROC tcpip()
        SocketCreate server;
        SocketBind server,"192.168.0.20", 5000;
        !SocketBind server,"172.16.44.240", 5000;
        SocketListen server;
        SocketAccept server,client;
        !Sending text to Vision Program
        SocketSend client,\Str :="Executing Python program";
        !Receiving number of detected object
        SocketReceive client,\Str :=num_objects;
        objects:=StrToVal(num_objects,num_objs);
    ENDPROC
    PROC receiveData()
            SocketReceive client,\Str :=x_coordinate;
            posx :=StrToVal(x_coordinate,X);
       !     SocketReceive client,\Str :=dummy;
            SocketReceive client,\Str :=y_coordinate;
            posy := StrToVal(y_coordinate,Y);
            Obj:=[[888.647981627+248+X,-3.101979233+Y,1192.532782595],[0.004363108,0.006108556,-0.999971823,-0.000041884],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ENDPROC
    PROC moveToObj()
        
        MoveJ Obj,v100,z100,tool0\WObj:=wobj0;
    ENDPROC
    
    PROC open_gripper()        
        SetDO DO10_2, 1;
        Waittime 3;
        SetDO DO10_2, 0;
        Waittime 1;
        
     ENDPROC

    PROC close_gripper()       
        SetDO DO10_1, 1;
        Waittime 3;
        SetDO DO10_1, 0;
        Waittime 1;
        
    ENDPROC
ENDMODULE