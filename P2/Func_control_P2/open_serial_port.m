function sp = open_serial_port(puerto,baudios)


delete(instrfind('Port',puerto));
sp = serial(puerto,'BaudRate',baudios);

end