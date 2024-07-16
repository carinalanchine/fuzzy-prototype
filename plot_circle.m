function circle = plot_circle(xc, yc, r);
% Plota um circulo na tela
% Desenha circulo de centro (xc, yc) de raio r
% xc = abscissa do centro do circulo
% yc = ordenada do centro do circulo
% r = raio do circulo
%
theta = linspace(0,2*pi,100);  % Define um vetor de 100 valores de theta entre o e 2*pi
x = xc + r*cos(theta);         % Gera a coordenada x
y = yc + r*sin(theta);         % Gera a coordenada y
circle = plot(x,y);                     % Plota o robo