clc;  #...clear command line 
clear all; #...clear variables
close all; #... clear figures

bits = [0 1 0 0 1 1];

#... modulation

bitrate = 1;
voltage = 5;

sampRate = 1000;
sampTime = 1/sampRate;

endTime = length(bits)/bitrate;
time = 0:sampTime:endTime;

index = 1;
sign = 1;
if bits(index) == 0
	sign = -1*sign;
endif

for i=1:length(time)
	
	modulation(i) = sign *voltage;
	
	if time(i)*bitrate >= index - 1/2
		modulation(i) = -modulation(i);
		
	endif
	
	if time(i)*bitrate >= index
		index= index+1;
		
		if index<= length(bits) && bits(index) == 1
			sign = -1*sign;
		endif
	endif
end


plot(time, modulation, "linewidth", 2);
axis([0 endTime -voltage-5 voltage+5]);
grid on;

#... demodulation

index = 1;
prev = -5;

for i= 1:length(modulation)
	if time(i)*bitrate < index - 1/2
		if modulation(i) == prev;
			demodulation(index) = 0;
		else
			demodulation(index) = 1;
		endif
	endif
	if time(i)*bitrate >= index
		index = index+1;
		prev = -1*modulation(i);
	endif
end

disp(demodulation);
