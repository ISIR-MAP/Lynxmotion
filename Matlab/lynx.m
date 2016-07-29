
classdef lynx

    properties (SetAccess = public, GetAccess = public);
        port;
        ID;
        position;
        speed;
        com;
        time;
        Offset;
    end


	


     methods (Access = public)

        function obj = lynx(port)

        %  Initialize with port number
            obj.port=port;            
        end

        function setPosSpeed(obj,com,ID,position,speed)
        %setPosition : Set the position of a servo with the possibilite to
        %set the speed
        %ID : Channel used by the servo on the SSC-32U
        %Position :  500<position<2500
        %Speed : 10<speed<1000 
            obj.com=com;
            serial_link = serial(com);
            set(serial_link, 'Terminator', 'CR');
            set(serial_link,  'BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1);
            serial_link.FlowControl = 'none';
            fopen(serial_link);
            obj.ID=ID;
            obj.position=position;
            obj.speed=speed;
            
            IDS=num2str(ID);
            positionS=num2str(position);
            speedS=num2str(speed);
            
            ips=strcat('#',IDS,'P',positionS,'S',speedS);
            
            fprintf(serial_link,ips);
            disp('finished')
            clear serial_link
            fclose(instrfind)
        end
            
        function setPostime(obj,com,ID,position,time)
        %setPostime : Set the position of a servo with the possibilite to
        %set the time required to get to the desired position
        %ID : Channel used by the servo on the SSC-32U
        %Position : normally 500<position<2500
        %time : time in microseconds , 65535 max
            obj.com=com;
            serial_link = serial(com);
            set(serial_link, 'Terminator', 'CR');
            set(serial_link,  'BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1);
            serial_link.FlowControl = 'none';
            fopen(serial_link);
        
        
        
            obj.ID=ID
            obj.position=position
            obj.time=time
            
            IDS=num2str(ID)
            positionS=num2str(position)
            timeS=num2str(time)
            
            ips=strcat('#',IDS,'P',positionS,'T',timeS)
            
            fprintf(serial_link,ips)
            clear serial_link
            fclose(instrfind)
            
            
        end
        
        function setMultiplePosSpeed(obj,com,ID,position,speed)
		%AX12.setMultiplePositions Set the position of multiple consecutive actuators simultaneously.
        %   lynx.setMultiplePositions([ID1, ID2, ...],[pos1, pos2, ...],[speed1,speed2, ...])
        %   In this function its necessary to declare the speed for all
        %   servos , even if they are equal 
            obj.com=com;
            serial_link = serial(com);
            set(serial_link, 'Terminator', 'CR');
            set(serial_link,  'BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1);
            serial_link.FlowControl = 'none';
            fopen(serial_link);
			
            obj.ID=ID;
            obj.position=position;
            obj.speed=speed;
            
            
            
            % check if ID and position size are the same
            if length(ID) ~= length(position)
                disp('ERROR: IDs and positions vectors must be the same length');
                return;
            end
            if length(ID) ~= length(speed)
                disp('ERROR: IDs and speed vectors must be the same length');
                return;
            end
            
            L=length(ID);
            
            if L==6;
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(speed(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(speed(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(speed(3)),'#',num2str(ID(4)),'P',num2str(position(4)),'S',num2str(speed(4)),'#',num2str(ID(5)),'P',num2str(position(5)),'S',num2str(speed(5)),'#',num2str(ID(6)),'P',num2str(position(6)),'S',num2str(speed(6)));
            elseif L==5;
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(speed(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(speed(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(speed(3)),'#',num2str(ID(4)),'P',num2str(position(4)),'S',num2str(speed(4)),'#',num2str(ID(5)),'P',num2str(position(5)),'S',num2str(speed(5)));
            elseif L==4;
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(speed(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(speed(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(speed(3)),'#',num2str(ID(4)),'P',num2str(position(4)),'S',num2str(speed(4)));
            elseif L==3;
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(speed(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(speed(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(speed(3)));
            elseif L==2;
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(speed(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(speed(2)));
            elseif L==1;
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(speed(1)));
                
            end
                
            fprintf(serial_link,ips)
            clear serial_link
            fclose(instrfind)
        end
        
        function setMultiplePostime(obj,com,ID,position,time)
		%AX12.setMultiplePositions Set the position of multiple consecutive actuators simultaneously.
        %   lynx.setMultiplePositions(COM,[ID1, ID2, ...],[pos1, pos2, ...],[time1,time2, ...])
        %   In this function its necessary to declare the time for all the
        %   servos , even if they are equal 
            obj.com=com
            serial_link = serial(com);
            set(serial_link, 'Terminator', 'CR');
            set(serial_link,  'BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1);
            serial_link.FlowControl = 'none';
            fopen(serial_link);
			
            obj.ID=ID;
            obj.position=position;
            obj.time=time;
            
            
            
            % check if ID and position size are the same
            if length(ID) ~= length(position)
                disp('ERROR: IDs and positions vectors must be the same length');
                return;
            end
            if length(ID) ~= length(time)
                disp('ERROR: IDs and time vectors must be the same length');
                return;
            end
            
            L=length(ID)
            
            if L==6
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(time(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(time(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(time(3)),'#',num2str(ID(4)),'P',num2str(position(4)),'S',num2str(time(4)),'#',num2str(ID(5)),'P',num2str(position(5)),'S',num2str(time(5)),'#',num2str(ID(6)),'P',num2str(position(6)),'S',num2str(time(6)));
            elseif L==5
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(time(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(time(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(time(3)),'#',num2str(ID(4)),'P',num2str(position(4)),'S',num2str(time(4)),'#',num2str(ID(5)),'P',num2str(position(5)),'S',num2str(time(5)));
            elseif L==4
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(time(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(time(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(time(3)),'#',num2str(ID(4)),'P',num2str(position(4)),'S',num2str(time(4)));
            elseif L==3
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(time(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(time(2)),'#',num2str(ID(3)),'P',num2str(position(3)),'S',num2str(time(3)));
            elseif L==2
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(time(1)),'#',num2str(ID(2)),'P',num2str(position(2)),'S',num2str(time(2)));
            elseif L==1
                ips=strcat('#',num2str(ID(1)),'P',num2str(position(1)),'S',num2str(time(1)));
                
            end
                
            fprintf(serial_link,ips);
            clear serial_link;
            fclose(instrfind);
        end
        
        function setOffset(obj,com,ID,Offset)
        %setOffset allows to set an offset for a servo, values range
        %between -100 and 100
            obj.com=com
            serial_link = serial(com);
            set(serial_link, 'Terminator', 'CR');
            set(serial_link,  'BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1);
            serial_link.FlowControl = 'none';
            fopen(serial_link);
            obj.ID=ID;
            obj.Offset=Offset;
            
            
            
            IDS=num2str(ID);
            OffsetS=num2str(Offset);
            
            
            ips=strcat('#',IDS,'PO',OffsetS);
            
            fprintf(serial_link,ips);
            clear serial_link;
            fclose(instrfind);
            
        end
      end
end