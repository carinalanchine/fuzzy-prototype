function plot_attack(x,y,j)
if j == 1
    attack = plot([x x],[y y+30]);
else
    attack = plot([x x],[y y-30]);
end
pause(2);
delete(attack);
end