clc;
clear all;
close all;

bits = [ 1 0 1 1 0 0 1 ];

#...modulation

bitrate = 1;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

a= 3 #amplitude
f= 2 #frequency
modulation = a*sin(2*pi*f*time);

index = 1;

for i = 1:length(time)
	if(bits(index)==0)
		modulation(i) = 0;
	endif
	
	if time(i)*bitrate>= index
		index = index + 1;
	end
endfor

plot(time, modulation)
axis([0 end_time -2*a 2*a]);
grid on;

#demodulation
index = 1;

for i = 1:length(modulation)
	if modulation(i) != 0
		demodulation(index) = 1;
	else
		demodulation(index) = 0;
	end
	
	if time(i)*bitrate >= index
		index = index+1;
	end
endfor

disp(demodulation);







