clear all
close all
clc
%defining search space
x = linspace(0,0.6,150);
y = linspace(0,0.6,150);
num_cases = 50
f = get_stalagmite(x,y);

tic
% Study 1 - Statistical Behaviour
for i = 1:num_cases
    [inputs , fopt(i)] = ga(@stalagmite,2);
    xopt(i) = inputs(1);
    yopt(i) = inputs(2);
end 

study1_time = toc
%plot
figure(1)
subplot(2,1,1)
hold on
surfc(x,y,-f)
shading interp
plot3(xopt,yopt,-fopt,'marker','o','markersize',5,'markerfacecolor','r')
title('unbounded inputs')
subplot(2,1,2)
plot(-fopt)
xlabel('Iterations')
ylabel('Function minimum')

tic
% study 2 - statistical behavior- with upper and lower bounds
for i = 1:num_cases
    [inputs, fopt(i)] = ga(@stalagmite,2,[],[],[],[],[0;0],[1;1]);
    xopt(i) = inputs(1);
    yopt(i) = inputs(2);
end
study2_time = toc

figure(2)
subplot(2,1,1)
hold on 
surfc(x, y, -f)
shading interp
plot3(xopt,yopt,-fopt,'marker','o','markersize',5,'markerfacecolor','r')
title('Bounded inputs')
subplot(2,1,2)
plot(-fopt)
xlabel('Iterations')
ylabel('Function minimum')

% syudy 3 - increasing GA Iterations
options = gaoptimset('ga');
options = gaoptimset(options,'populationsize',170);

tic
for i = 1:num_cases
    [inputs , fopt(i)] = ga(@stalagmite,2,[],[],[],[],[0;0],[1;1],[],[],options);
    xopt(i) = inputs(1);
    yopt(i) = inputs(2);
end
study3_time = toc
figure(3)
subplot(2,1,1)
hold on
surfc(x,y,-f)
shading interp
plot3(xopt,yopt,-fopt,'marker','o','markersize',5,'markerfacecolor','r')
title('bounded inputs with modified population size')
subplot(2,1,2)
plot(-fopt)
xlabel('Iterations')
ylabel('Function minimum')

Total_time = study1_time + study2_time + study3_time

% creating a 2D mesh
[xx yy] = meshgrid(x,y);
% evaluate the stalagmite function
for i = 1:length(xx)
    for j = 1:length(yy)
        input_vector(1)=xx(i,j);
        input_vector(2)=yy(i,j);
        f(i,j) = stalagmite(input_vector);
    end
end

surfc(xx,yy,f)
shading interp
[x,fval] = ga(@stalagmite,2)
