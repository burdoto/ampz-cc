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
     lineBtnAdd30 = height * 0.8;
    lineBA30Space = width * 0.33;
    lineBtnCancel = height;
    lineBtCclSpace = width * 0.142857143;
    buttonHeight = height / 5;

    -- print remaining time
    remMin = math.floor(timer / 60);
    remSec = timer - (remMin * 60);
    monitor.setCursorPos(lineRemSpace + 1, lineRemaining);
    monitor.write(string.format("%02d:%02d", remMin, remSec));

    -- print +time button
    monitor.setCursorPos(lineBA30Space + 1, lineBtnAdd30);
    monitor.blit("+30s", "0000","5555");

    -- print cancel button
    monitor.setCursorPos(lineBtCclSpace + 1, lineBtnCancel);
    monitor.blit("Cancel", "000000","eeeeee");

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
    -- but         ract
    print("touch["..x..","..y.."]")
    print("add30["..lineBA30Space..","..lineBtnAdd30..","..(lineBtnAdd30 + 4).."]")
    print("cancel["..lineBtCclSpace..","..lineBtnCancel..","..(lineBtCclSpace + 6).."]")
    if y == lineButton and x > lineBA30Space and x <= (lineBtnAdd30 + 4) then
        -- +30sec button
        timer = timer + 30;
    elseif y == lineBtnCancel and x > lineBtCclSpace and x <= (lineBtCclSpace + 6) then
        -- cancel button
        timer = 0;
    end
end
result = timer > 0;
if inverse then result = not result end
redstone.setOutput(outputSide, result);
end
