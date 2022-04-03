MODULE Module1
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   This code enables RobotStudio to act as a server and will receive data from MATLAB (client)
    !	Put a watch on data variable
    ! Author: Nikhil Prasad (vdb5699)
    !
    ! Version: 2.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    VAR	socketdev serverSocket;
	VAR	socketdev clientSocket;
	VAR	string data;
	
	Proc main()
		SocketCreate serverSocket;
		SocketBind serverSocket, "192.168.0.20", 1025;
        SocketListen serverSocket;
        SocketAccept serverSocket, clientSocket,\time:=WAIT_MAX;
        
        !********************************************************
        ! After executing the above code, Connect MATLAB to same IP address via TCP function.
        !********************************************************
        
        
        !********************************************************
        ! The server will need to be sent some data from MATLAB to recieve, 
        ! this will need to be done via fwrite function on MATLAB
        !********************************************************
        
        SocketReceive clientSocket \Str:=data; 
        SocketSend clientSocket \Str:="Data Received";
        
        SocketClose clientSocket;   ! Closing sockets after data has been recieved
        SocketClose serverSocket;
        
        ! Error Handling
        ERROR
        
        IF ERRNO=ERR_SOCK_TIMEOUT THEN  ! Retry connecting if socket timeout
            RETRY;  
        ELSEIF ERRNO=ERR_SOCK_CLOSED THEN   ! Close sockets and retry connecting if sockets closed
            SocketClose clientSocket;   
            SocketClose serverSocket;
            SocketCreate serverSocket;
            SocketBind serverSocket, "192.168.0.20", 1025;
            SocketListen serverSocket;
            SocketAccept serverSocket, clientSocket, \Time:=WAIT_MAX;
            RETRY;
        ELSE
            stop;
        ENDIF
    ENDPROC
ENDMODULE