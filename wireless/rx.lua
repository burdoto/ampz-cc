modem = peripheral.find('modem') or error('modem not found', 1)
channel = tonumber(arg[1]) or error('first argument must be channel id', 1)
side = arg[2] or error('second argument must be output side', 1)

modem.open(channel)
previous = -1
while (true) do
    chl = -1
    repeat
        event, mdmside, chl, replyChannel, value, distance = os.pullEvent("modem_message")
    until channel == chl

    print(channel..' -> '..value..' -> '..side)
    redstone.setAnalogOutput(side, value)
end
