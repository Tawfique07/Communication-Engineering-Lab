clc;  #...clear command line 
clear all; #...clear variables
close all; #... clear figures

bits = [1 0 1 1 0 0 1];

#... Modulation

bitrate = 1; 
voltage = 5;

sampRate = 1000;
sampTime = 1/sampRate;

endTime = length(bits)/bitrate;
time = 0:sampTime:endTime;

index = 1;

for i = 1:length(time)
	if bits(index)==1
		modulation(i) = voltage;
	else
		modulation(i) = -voltage;
	endif
	if time(i)*bitrate>=index
		index = index + 1;
	endif
end


plot(time, modulation, "LineWidth", 1);
axis([0 endTime -voltage-5 voltage+5]);
grid on;


#... demodulation

index = 1;

for i = 1:length(modulation)
	if modulation(i)==voltage
		demodulation(index) = 1;
	else
		demodulation(index) = 0;
	endif
	
	if time(i)*bitrate>=index
		index = index+1;
	endif	
end

disp(demodulation);
