input = 'right'
output = 'top'
threshold = 14
wait = 20

while (true) do
    os.pullEvent('redstone')
    value = redstone.getAnalogInput(input)
    if (threshold <= value) then
        print('restarting engine ('..wait..' sec timeout)')
        redstone.setOutput(output, true)
        sleep(wait)
        redstone.setOutput(output, false)
    end
end
