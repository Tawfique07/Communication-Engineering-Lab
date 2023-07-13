clc;
clear all;
close all;

bits = [ 1 1 0 0 0 0 1 0 0 0 0 ]

%...modulation

bitrate = 1;
voltage = 5;

sampling_rate  = 1000;
sampling_time = 1/sampling_rate;


end_time = length(bits);
time = 0:sampling_time:end_time;


zero = 0;
one = 0;
for i = 1: length(bits)
	if bits(i) == 1
		zero = 0;
		one = one + 1;
	else
		zero += 1;
	end
	if zero == 4
		bits(i) = -1; zero = 0;
		if rem(one,2) == 0
			bits(i-3) = 1;
		end
	end
end

index = 1;
sign = -1;

for i = 1:length(time)
	modulation(i) = 0;
	if bits(index) != 0
		modulation(i) = sign * voltage;
	end
	if time(i)*bitrate >= index
		index = index+1;
		if index<=length(bits) && bits(index) == 1
			sign = -1 * sign;
		end
		
		
	end
end

plot(time, modulation, "LineWidth", 2)
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0 0]);
grid on;
disp(bits);
%...demodulation
index = 1







	
	
	
	
	
	
