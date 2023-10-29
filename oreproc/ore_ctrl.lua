-- for a 3x2 monitor

os.loadAPI('ores.lua')
modem=peripheral.find('modem') or error('modem not found', 1)

while (true) do 
    term.clear()
    term.setCursorPos(1,1)

    -- print UI
    term.write('-- Ore Processing Controls --')
    print('')

    i = 1
    while (i<=#ores.data) do
        ore=ores.data[i]

        -- print entry name
        --term.write(i)
        term.write(' '..ore.name)
        len=#ore.name
        while (len <= 21) do
            term.write('.')
            len=len+1
        end

        -- print on/off button
        local txt, bg
        if (ore.state) then
            txt=' on  '
            bg ='55555'
        else
            txt=' off '
            bg ='eeeee'
        end
        term.blit(txt,'fffff',bg)
        print('')
        i=i+1
    end

    -- ui events
    event, side, x, y = os.pullEvent("monitor_touch")
    print('side: ',side,'; x: ',x,'; y: ',y)
    if(x>23 and x<29) then
        i=y-1 -- offset for a 3x2 monitor
        ores.data[i].state=not ores.data[i].state
        print('ore: ',ores.data[i].name,'; state: ',ores.data[i].state)
        modem.transmit(i+42000,0,ores.data[i].state)
    end

    -- save state
    ores.save()
end
