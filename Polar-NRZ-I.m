clc;  #...clear command line 
clear all; #...clear variables
close all; #... clear figures

bits = [0 1 0 0 1 1 1 0];

#... Modulation

bitrate = 1; 
voltage = 5;

sampRate = 1000;
sampTime = 1/sampRate;

endTime = length(bits)/bitrate;
time = 0:sampTime:endTime;

index = 1;
sign = 1; 
#... Assuming last state was pisitive
if bits(index) == 1
	sign = -1*sign;
endif

for i=1:length(time)
	modulation(i) = voltage*sign;
	if time(i)*bitrate>=index
		index = index+1;
		if index<=length(bits) && bits(index)==1
			sign = -1*sign;
		endif
	endif
end

plot(time, modulation, "LineWidth", 2);
axis([0 endTime -voltage-5 voltage+5]);
grid on;


#...demodulatoin

index = 1;
previous = voltage;

for i = 1:length(modulation)
	if modulation(i)==previous
		demodulation(index) = 0;
	else
		demodulation(index) = 1;
	endif
	if time(i)*bitrate >= index
		index = index + 1;
		previous = modulation(i);
	endif
end


disp(demodulation);


