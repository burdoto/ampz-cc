outputSide='bottom'

 -- starts from 1, not 0
oreId=os.getComputerID()-9

os.loadAPI('ores.lua')
modem=peripheral.find('modem') or error('modem not found', 1)

ore=ores.data[oreId]
modem.open(oreId+42000)
print('Enable for ore '..ore.name..' on channel '..ore.channel)
local val
if (ore.state) then
    val=1
else
    val=0
end
redstone.setAnalogOutput(outputSide,val)

state=false
while (true) do
    local event, side, channel, replyChannel, message, distance
    repeat
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == ore.channel

    local val
    if (message) then
        val=1
    else
        val=0
    end
    print('State switch for '..ore.name..' to: '..val..' on side '..outputSide)
    redstone.setAnalogOutput(outputSide,val)
end
