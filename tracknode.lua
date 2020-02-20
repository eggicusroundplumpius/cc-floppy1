term.clear()
term.setCursorPos(1,1)
print("Track Node v0.1")
print("---------------------------------------------------")
print(" ")
isconfig = fs.exists("config.txt")
if isconfig then
    print("config found!")
    config = fs.open("config.txt", "r")
    
    channel = tonumber(config.readLine())
    print("channel is", channel)
    
    protocol = config.readLine()
    print("protocol set to", protocol)
    
    nodeID = config.readLine()
    print("nodeID:", nodeID)
    
    print("  ")
    config.close()
else
    print("config not found! using defaults..")
    print("  ")
    channel = 437
    print("channel:", channel)
    protocol = "tn_upl"
    print("protocol:", protocol)
    nodeID = "unknown_node"
    print("nodeID:", nodeID)
    print("  ")
end

isconnected = peripheral.isPresent("top")
if isconnected then
    print("detected peripheral on top")
    iswireless = peripheral.getType("top")
    if iswireless == "modem" then
        print("modem found")
        modem = peripheral.wrap("top")
        modem.open(channel)
        rednet.open("top")
        print("rednet open!")
        print("  ")
        print("--------------------------------")
        print("Ready!")
        print("--------------------------------")
        print("  ")
        A = nil
        B = nil
        while true do
            if redstone.getInput("right") then
                A = "east"
                print("east triggered")
                for i = 30, 0, 1 do
                    if redstone.getInput("left") then
                        print("west triggered")
                        B = "west"
                        break
                    end
                    sleep(0.1)
                end
                if B == "west" then
                    print("train inbound!")
                    rednet.broadcast("west:inbound", protocol)
                    print("rednet broadcast!")
                    sleep(1)
                end
            end
            
            if redstone.getInput("left") then
                A = "west"
                print("west triggered")
                for i = 30, 1, 1 do
                    if redstone.getInput("right") then
                        print("east triggered")
                        B = "east"
                        break
                    end
                    sleep(0.1)
                end
                if B == "east" then
                   print("train outbound!")
                   rednet.broadcast("east:outbound", protocol)
                   print("rednet broadcast!")
                   
                end
            end
            sleep(0.1)
        end
    else
        print("FATAL ERROR: No Modem Detected.")
    end
end     
