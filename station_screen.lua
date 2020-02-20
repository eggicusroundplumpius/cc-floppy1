term.native()
term.clear()
term.setCursorPos(1,1)

print("---------------------------------------------------")
print("WARNING: This terminal is networked. Mounted drives and peripherals are exposed to the network.")
print("---------------------------------------------------")

--START

monitor_0 = peripheral.wrap("monitor_4")
monitor_0.setTextScale(0.5)
monitor_1 = peripheral.wrap("monitor_1")
monitor_1.setTextScale(0.5)
modem = peripheral.wrap("back")
modem.open(2534)
rednet.open("back")

lot = false

function getData ()

    local side, direction
    local sender, message, protocol = rednet.receive("stonehaven_trains")
    
    --Message Syntax: "side:direction"
    
    for i in message do
        if i == ":" then
            lot = true
        else
            if lot == true then
                direction = direction + i
            else
                side = side + i
            end
        end
    end
    
    print("["+os.time()+"] "+side+"/"+direction)
    
    return side, direction
    
end

monitor_0.clear()
monitor_1.clear()

while true do
    
    term.redirect(monitor_0)
    term.setCursorPos(1,1)
    term.write("Stonehaven Station / Train Activity")
    term.setCursorPos(1,2)
    term.write("-----------------------------------")

    term.redirect(monitor_1)
    term.setCursorPos(1,1)
    term.write("Stonehaven Station / Train Activity")
    term.setCursorPos(1,2)
    term.write("-----------------------------------")
    
    local side, direction = getData()
    
    term.redirect(monitor_0)
    local x, y = term.getCursorPos()
    if y == 15 then
        term.setCursorPos(1,3)
        term.clearLine()
    else
        term.setCursorPos(1, y+1)
    end
    term.write(direction+": "+side)
    
    term.redirect(monitor_1)
    local x, y = term.getCursorPos()
    if y == 15 then
        term.setCursorPos(1,3)
        term.clearLine()
    else
        term.setCursorPos(1, y+1)
    end
    term.write(direction+": "+side)
    
end
