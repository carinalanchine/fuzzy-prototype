function hidden = isHidden(xCircle,yCircle,r,xBarreira,yBarreira)

range = yBarreira-(yCircle+r);

if range >= 0 && range < 15
    if xCircle-r >= xBarreira && xCircle+r <= xBarreira+25
        hidden = true;

    else
        hidden = false;
    end
    return;
end
    hidden = false;
end