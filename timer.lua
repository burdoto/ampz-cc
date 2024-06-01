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
    lineRemaining = math.floor(height * 0.4);
    lineRemSpace = math.floor(width * 0.142857143);
    lineBtnAdd30 = math.floor(height * 0.8);
    lineBA30Space = math.floor(width * 0.256);
    lineBtnCancel = height;
    lineBtCclSpace = math.floor(width * 0.33);

    -- print remaining time
    remMin = math.floor(timer / 60);
    remSec = timer - (remMin * 60);
    monitor.setCursorPos(lineRemSpace + 1, lineRemaining);
    monitor.write(string.format("%02d:%02d", remMin, remSec));

    -- print +time button
    monitor.setCursorPos(lineBA30Space + 1, lineBtnAdd30);
    monitor.blit("+5min", "00000", "55555");

    -- print cancel button
    monitor.setCursorPos(lineBtCclSpace + 1, lineBtnCancel);
    monitor.blit("Stop", "0000", "eeee");

    repeat
        event, id, x, y = os.pullEventRaw()
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
        --print("touch["..x..","..y.."]")

        if y == lineBtnAdd30 and x > lineBA30Space and x < (lineBtnAdd30 + 3) then
            -- +30sec button
            timer = timer + 300;
        elseif y == lineBtnCancel and x > lineBtCclSpace and x < (lineBtCclSpace + 5) then
            -- cancel button
            timer = 0;
        end
    end
    --print(timer);
    result = timer > 0;
    if inverse then result = not result end
    redstone.setOutput(outputSide, result);
end
