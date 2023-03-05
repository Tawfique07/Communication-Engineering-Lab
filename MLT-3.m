clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [1 0 1 0 1 1 0 1 1];

#...modulation

bitrate = 1;
voltage = 5;

sampRate = 1000;
sampTime = 1/sampRate;

endTime = length(bits)/bitrate;
time = 0:sampTime:endTime;

index = 1;
sign = -1;
prev = 0;

for i=1:length(time)
	if bits(index) == 0
		modulation(i)=prev;
	else
		if prev == 0
			modulation(i) = voltage*sign;
		else
			modulation(i) = 0;
		endif
	endif
	if time(i)*bitrate >= index
		index = index + 1;
		prev = modulation(i);
		if index<=length(bits) && prev ==0 && bits(index)==1
			sign = -1*sign;
		endif
	endif
end

plot(time, modulation, "LineWidth", 2);
axis([0 endTime -voltage-5 voltage+5]);
grid on;


#... demodulation

index = 1;
prev = 0;

for i = 1:length(modulation)
	if modulation(i)==prev
		demodulation(index) = 0;
	else
		demodulation(index) = 1;
	endif
	
	if time(i)*bitrate>=index
		prev = modulation(i);
		index = index+1;
	endif	
end

disp(demodulation);
