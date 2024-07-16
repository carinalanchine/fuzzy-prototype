close all
clc
warning off all

health = 120;
ammo = 120;
action = Action.stop;

yi=0; yf=100;
xi=0; xf=100;
r = 5;
acaoJogador = 0;
yCircle = 0;
xCircle = 0;
xBarreira = 50;
YBarreira = 30;
yDivisoria = 50;
yBarreira = 30;

Axis = ([xi xf yi yf]);
plot([xi xf xf xi xi],[yi yi yf yf yi]);

while yCircle < 6 || yCircle > 46 
    yCircle = input('Posição y inicial? (6 <= y <= 46)');
end

while true
    xCircle = input('Posição x inicial? (6 <= x <= 94)');

    if xCircle > 6 && xCircle < 94
        if abs(yBarreira-yCircle) > r
            break;
        else
            if xCircle+r < xBarreira || xCircle-r > xBarreira+25
                break;
            end
        end
    end
end

circle = plot_circle(xCircle, yCircle, r);
hold on;
axis([0 100 0 100]);

fplot(yDivisoria, [0 100]);

xJogador = 50;
yJogador = 80;
jogador = plot_circle(xJogador, yJogador, r);

fplot(yBarreira, [xBarreira xBarreira+25]);

hidden = isHidden(xCircle,yCircle,r,xBarreira,yBarreira);

if hidden == true
    action = Action.hide;
end

% -----------------------------------------------------

tmp_arq = readfis('jogo');

while (acaoJogador ~= 2 && health > -20)
    fprintf('\n1 => Atacar \n');
    fprintf('2 => Sair \n');
    acao = input('Ação: ');

    switch acao 
        case 1
            if action ~= Action.hide
                plot_attack(xJogador,yJogador-r,0);
                if action == Action.run_away
                    health = health-10;
                else
                    health = health-20;
                end
            end

        case 2
            break;
    end

    saida = evalfis([ammo health], tmp_arq);

    if saida <= 10
        saida = 1;
        actionStr = 'Hide';
    elseif saida > 10 && saida <= 40
        saida = 2;
        actionStr = 'Run away';
    elseif saida > 40 && saida <= 65
        saida = 3;
        actionStr = 'Stop';
    elseif saida > 65 && saida <= 90
        saida = 4;
        actionStr = 'Walk around';
    elseif saida > 90
        saida = 5;
        actionStr = 'Attack';
    end

    switch saida
        case 1
            if action ~= Action.hide
                delete(circle);
                xCircle = xBarreira+10;
                yCircle = yBarreira-r-2;
                circle = plot_circle(xCircle,yCircle,r);
            end

            health = health + 20;
            action = Action.hide;

        case 2 
            action = Action.run_away;

            distFX = (xf-r)-xCircle;
            distIX = xCircle-(xi+r);
            if (distFX > distIX)
                xCircle = xf-r;
            else
                xCircle = xi+r;
            end

            distFY = (yDivisoria-r)-yCircle;
            distIY = yCircle-(yi+r);
            if (distFY > distIY)
                yCircle = yDivisoria-r;
            else
                yCircle = yi+r;
            end

            ammo = ammo + 20;
            health = health + 20;
            delete(circle);
            circle = plot_circle(xCircle,yCircle,r);

        case 3
            action = Action.stop;

        case 4
            distFX = (xf-r)-xCircle;
            distIX = xCircle-(xi+r);
            xCircle = max(distFX,distIX);

            distFY = (yDivisoria-r)-yCircle;
            distIY = yCircle-(yi+r);
            yCircle = max(distFY,distIY);

            delete(circle);
            circle = plot_circle(xCircle,yCircle,r);

            hidden = isHidden(xCircle,yCircle,r,xBarreira,yBarreira);
            if hidden == true
                action = Action.hide;
            else
                action = Action.walk_around;
            end

        case 5
            if action == Action.hide
                xCircle = 25;
                delete(circle);
                circle = plot_circle(xCircle,yCircle,r);
            end
            
            action = Action.attack;
            plot_attack(xCircle,yCircle+r,1);
            ammo = ammo - 80;
    end

    fprintf("\nAção: %s\nSaude: %d\nMunicao: %d\n", actionStr,health,ammo);

end