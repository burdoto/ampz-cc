 monitor = peripheral.find("monitor");
 timer = 0;
 timerId = 0;

 outputSide = arg[1];
 inverse = arg[2] == "-i";

 monitor.clear();
 timerId = os.startTimer(1);
 while true do
     -- calculate positions
     width, height = monitor.getSize();
    lineRemaining = height * 0.4;
    lineRemSpace = width * 0.142857143;
    lineButton = height * 0.8;
    lineBtnSpace = width * 0.2857;
    buttonHeight = height / 5;

    -- print remaining time
    remMin = math.floor(timer / 60);
    remSec = timer - (remMin * 60);
    monitor.setCursorPos(lineRemSpace + 1, lineRemaining);
    monitor.write(string.format("%02d:%02d", remMin, remSec));

    -- print +time button
    monitor.setCursorPos(lineBtnSpace + 1, lineButton);
    monitor.blit("+30s", "0000","aaaa");

    repeat event, id, x, y = os.pullEventRaw()
        -- debug print(event); if id ~= nil then print(id) end
    until event == "timer" or event == "monitor_touch";
    if event == "timer" and id == timerId then
        -- timer elapse
        if timer > 0 then
            timer = timer - 1;
        end
        timerId = os.startTimer(1);
    elseif (event == "monitor_touch") then
        -- button interact
        if y == lineButton and x > lineBtnSpace and x < (lineBtnSpace + 4) then
            timer = timer + 30;
        end
    end
    result = timer > 0;
    if inverse then result = not result end
    redstone.setOutput(outputSide, result);
end
