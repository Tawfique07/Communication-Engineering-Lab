clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [ 1 0 0 0 0 0 0 0 0 0 1];

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

subplot(2,1,1);
plot(time, modulation, "LineWidth", 2);
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

#...scrambling

for i=1:length(bits)
	cnt = 0
	for j=i:i+8
		if j>length(bits)
			break;
		endif
		if bits(j)==1
			break;
		else
			cnt = cnt + 1;
		endif
	endfor
	
	if cnt==8
		bits(i+2) = -1;
		bits(i+3) = 1;
		bits(i+5) = -1;
		bits(i+6) = 1;
	endif
	
end

disp(bits);

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
		if index <= length(bits) && bits(index)!=0
			sign = -1 * sign *bits(index);
		endif
	endif
end

subplot(2,1,2);
plot(time, modulation, "LineWidth", 2);
axis([0 endTime -voltage-5 voltage+5]);
grid on;
