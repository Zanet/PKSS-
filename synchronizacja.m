%Skrypt do synchronizacji czasu
%Wysy�amy zapytanie do serwera
%Otrzymujemy 11 bajt�w (10 znak�w + '\0'), kt�re wklejamy bezpo�rednio do
%Windowsowej komendy 'time'

%must be run as administrator ! 
%if not try runas /user:USERNAME(Piotr) notepad
%ip address wil be given in the future

clear all; 

PORT_NUMBER = 5001;
IP = '192.168.56.101';

t = tcpip(IP, PORT_NUMBER); 
fopen(t);
fwrite(t,'!getTime');
[A, COUNT] = fread(t, 12); 
if(COUNT == 12)
    text = char(A.')
    fclose(t);
    delete(t)

    command = 'echo HH:MM:00 PM | time';
    hour = text(1:2);
    minute = text(4:5);
    command = strrep(command, 'HH', hour);
    command = strrep(command, 'MM', minute);

    system(command);
else
    echo 'Receive error! Size mismatch.'
end