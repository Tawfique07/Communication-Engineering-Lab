clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [ 1 0 0 0 0 0 0 0 0 1];

#... Modulation

bitrate = 1; #... Number of bits per second
voltage = 5;

samplingRate = 1000;
samplingTime = 1/samplingRate;

endTime = length(bits)/bitrate;
time = 0:samplingTime:endTime;

index = 1;
sign = 1;

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

cnt = 0
for i=1:length(bits)
	if bits(i)==1
		cnt = 0;
		continue;
	endif
	
	if bits(i) == 0
		cnt = cnt +1;
	endif
	
	if cnt == 8
		cnt = 0;
		bits(i) = 1;
		bits(i-1) = -1;
		bits(i-3) = 1;
		bits(i-4) = -1;
	endif
	
end

index = 1;
sign = 1;

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

#... demodulation

index = 1;
prev = -voltage;

for i= 1:length(modulation)
	if prev != modulation(i)
		demodulation(index) = 1;
	else
		demodulation(index) = -1;
	endif
	
	if modulation(i) == 0
		demodulation(index) = 0;
	endif
	
	if time(i)*bitrate >= index
		if modulation(i)!=0
			prev = modulation(i);
		endif
		index = index+1;
	endif
end

for i=1:length(demodulation)
	if demodulation(i) == -1
		demodulation(i) = 0;
		demodulation(i+1) = 0;
	endif
end

disp(demodulation);

