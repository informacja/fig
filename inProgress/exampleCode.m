% clc
clear all

t=linspace(0,5,1000);
x=2*sin(2*pi*4*t);

figure(1), tiledlayout("flow"), nexttile
plot(t,x)
hold on
plot(t,2*x)
hold off
xlabel('aaa')
xlabel('Normalized Time [\%]','Interpreter','latex','FontSize',12)
ylabel('X-Trajectory of Ankle Landmark [m]','Interpreter','latex','FontSize',12)
legend('Xsens (Treadmill)','bbb','Interpreter','latex','FontSize',9)
nexttile, plot(t,x)
xlabel('bbb')
nexttile, plot(t,x)
xlabel('aaa')
nexttile, plot(t,x)
xlabel('bbb')
figPW("exportPdf", 1, "openFolder", 1, "TNR", 1, "styleLudwin", 1, "overwrite", 1,'openfile', 1, 'maxF', 1, 'timestamp', 0)

figure(2); sgtitle("Figure sgtitle");
figure(3); title("Figure 3");
figPSW