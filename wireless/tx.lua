modem = peripheral.find('modem') or error('modem not found', 1)
side = arg[1] or error('first argument must be input side', 1)
channel = tonumber(arg[2]) or error('second argument must be channel id', 1)

previous = -1
while (true) do
    os.pullEvent('redstone')
    value = redstone.getAnalogInput(side)
    if (value ~= previous) then
        print(side..' -> '..value..' -> '..channel)
        modem.transmit(channel, 0, value)
        previous = value
    end
end
