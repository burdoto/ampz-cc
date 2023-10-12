length=5
width=5

function sel(name)
    i=1
    found=false
    while(i<=4*4)do
        turtle.select(i)
        detail=turtle.getItemDetail()
        if((not(detail==nil)) and detail.name==name)then
            found=true
            break
        end
        i=i+1
    end
    return found
end

while (true) do
    x=0
    y=0

    dx=1
    dy=1

    b=false

    print('(x,y), (dx,dy), (b,t))')
    while((dx>0 or x>=0) and (dx<0 or x<width)) do
        while((dy>0 or y>0) and (dy<0 or y<length)) do
            print('(',x,',',y,'), (',dx,',',dy,'), (', b, ',',t,')')

            -- inspect crystal
            solid,obj=turtle.inspectDown()
            if(solid) then
                -- mine crystal
                if(obj.name=='ae2:quartz_cluster') then
                    turtle.digDown()
                end
            end

            solid,obj=turtle.inspectDown()
            if(not solid) then
                -- check depleted budding block
                turtle.down()
                solid,obj=turtle.inspectDown()
                if((solid and obj.name=='ae2:quartz_block') or not solid)then
                    -- replace depleted budding block with new, if possible
                    if(solid)then
                        turtle.digDown()
                    end
                    if (sel('ae2:flawed_budding_quartz'))then
                        turtle.placeDown()
                    end
                end
                turtle.up()
            end

            y=y+dy
            if(y>=length)then
                if(b)then
                    t=turtle.turnLeft
                    it=turtle.turnRight
                else
                    t=turtle.turnRight
                    it=turtle.turnLeft
                end
            elseif(y<=0)then
                if(b)then
                    t=turtle.turnRight
                    it=turtle.turnLeft
                else
                    t=turtle.turnLeft
                    it=turtle.turnRight
                end
            end
            if(t==nil and ((dy>0 or y>0) and (dy<0 or y<length)))then
                turtle.forward()
            end
        end

        if (t==nil)then
            print('error: turn action must not be nil here')
            exit()
        end

        x=x+dx
        dy=dy*-1
        if ((dx>0 or x>=0) and (dx<0 or x<width))then
            ut=t
            inv=false
        else
            ut=it
            x=x+(dx*2)
            inv=true
        end
        ut()
        if(not inv) then
            turtle.forward()
        end
        ut()
        t=nil
        if(inv)then
            --todo: Refill code here
        end
    end

    dx=dx*-1
    b =not b
end
