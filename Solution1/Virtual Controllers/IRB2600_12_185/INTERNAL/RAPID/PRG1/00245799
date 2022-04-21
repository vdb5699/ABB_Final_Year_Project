MODULE ModuleTest
    CONST robtarget phome:=[[1030.01,0.00,1456.88],[0.505101,0.494419,0.509028,0.491237],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget pcam:=[[1185.19,-0.24,944.23+235],[0.00845023,-0.00281222,0.99995,-0.00451948],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pobj:=[[571,712,979.5],[0.00509555,-0.00294276,-0.999978,0.00317152],[-1,-1,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget pcup:=[[1104.72,147.52,1030],[0.00841517,-0.00277237,0.99995,-0.00455974],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    PERS tooldata gripper := [TRUE, [[0,0,248], [1,0,0,0]], [4.4, [0, 0, 50], [1, 0, 0, 0], 0, 0, 0]];
    VAR string num_objects;
    VAR string x_coordinate;
    VAR string y_coordinate;
   
    VAR socketdev server;
    VAR socketdev client;
    VAR num X;
    VAR num Y;
   ! VAR num Z;
    VAR num num_objs;
   ! VAR num coordinate{128}; !Number of Object
    VAR bool posx;
    VAR bool posy;
    VAR bool posz;
    VAR num sum;
    VAR num x_count;
    VAR byte y_count;
    VAR bool objects;
    
	PROC main()
        SocketClose server;
!        move;
!        connecttcpip;
!        WHILE sum<num_objs DO
!            receiveData;
!            move2obj;
!            move;
!            SocketSend client,\Str :="Y";
!            sum:=sum+1;
!        ENDWHILE
!        SocketClose server;
	ENDPROC

    PROC connecttcpip()
        
        SocketCreate server;
        SocketBind server,"172.30.65.132", 5000;
        SocketListen server;
        SocketAccept server,client;
        SocketSend client,\Str :="Executing Python program";
        SocketReceive client,\Str :=num_objects;
        objects:=StrToVal(num_objects,num_objs);
    ENDPROC
    PROC receiveData()
 
            SocketReceive client,\Str :=x_coordinate;
            SocketReceive client,\Str :=y_coordinate;
            posx :=StrToVal(x_coordinate,X);
            posy := StrToVal(y_coordinate,Y);
            
        
    ENDPROC
  
    PROC move()
        
		MoveJ pcam, v100, fine, tool0;
        
    ENDPROC
    
    PROC move2obj()
        
        pobj:=[[X,Y,1227.5-248],[0.00509555,-0.00294276,-0.999978,0.00317152],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        MoveJ pobj,v50,fine,gripper;
        !release;
        MoveL Offs(pobj,0,0,-160),v50,fine,gripper;
        !grab;
        MoveL Offs(pobj,0,0,160),v50,fine,gripper;
        MoveJ pcup,v200,fine,gripper;
        waittime 1;
        !release;
    ENDPROC
    
!    PROC grab()
        
!        SetDO DO10_2, 1;
!        Waittime 3;
!        SetDO DO10_2, 0;
!        Waittime 1;
        
!     ENDPROC

!    PROC release()
        
!        SetDO DO10_1, 1;
!        Waittime 3;
!        SetDO DO10_1, 0;
!        Waittime 1;
        
!    ENDPROC

ENDMODULE