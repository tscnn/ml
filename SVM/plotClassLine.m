% plotClassLine(h, w, theta, s)
%
% Plots the classification plane of an artificial neuron with two inputs.
%
% input:    h        Handle of figure to plot into
%           w        Weight vector (two-dimensional)
%           theta    Classification threshold
%           s        Plot style (e.g. 'k-')
%
% By Jens Hocke and E. Barth from University of Luebeck

function plotClassLine(h,w,theta,s)

figure(h)

% and plot classification line
a=axis;
gy=[a(3) a(4)];
gx=[0 0];
if (w(1)~=0)
  gx(1)=(theta-w(2)*gy(1))/w(1);
  gx(2)=(theta-w(2)*gy(2))/w(1);
else
  gx=[a(1) a(2)];
  gy=[theta theta]/w(2);
end
hold on;
plot(gx,gy,s);
axis equal
axis(a);
hold off
