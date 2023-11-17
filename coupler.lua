input='back'
expect=11
output='left'

while (true) do
    os.pullEvent('redstone')
    x = redstone.getAnalogInput(input)
    print('got input '..x)

    if (x == expect) then
        redstone.setOutput(output, true)
        sleep(0.5)
        redstone.setOutput(output, false)
    end
end
