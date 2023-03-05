clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [0 1 0 0 1 0];

#... Modulation

bitrate = 1; #... Number of bits per second
voltage = 5;

samplingRate = 1000;
samplingTime = 1/samplingRate;

endTime = length(bits)/bitrate;
time = 0:samplingTime:endTime;

index = 1;
sign = -1;

for i=1:length(time)
	if bits(index) == 0
		modulation(i) = 0;
	else
		modulation(i) = sign*voltage;
	endif
	
	if time(i)*bitrate >= index
		index = index+1;
		if index <= length(bits) && bits(index)==1
			sign = -1 * sign;
		endif
	endif
end


plot(time, modulation, "LineWidth", 1);
axis([0 endTime -voltage-5 voltage+5]);
grid on;

#... demodulation

index = 1;

for i= 1:length(modulation)
	if modulation(i) == 0
		demodulation(index) = 0;
	else
		demodulation(index) = 1;
	endif
	if time(i)*bitrate >= index
		index = index+1;
	endif
end

disp(demodulation);
