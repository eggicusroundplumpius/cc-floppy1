term.clear()
term.setCursorPos(1,1)
print("---------------------------------------------------")
print("Rednet Listener v0.1")
print("---------------------------------------------------")
print("  ")

isconfig = fs.exists("config.txt")

if isconfig then
    print("config found!")
    config = fs.open("config.txt", "r")
    channel = tonumber(fs.readLine())
    nodeID = fs.readLine()
    config.close()
else
    print("config not found! using defaults..")
    channel = 1
    nodeID = "unknown_node"
end

modem = peripheral.wrap("top")
modem.open(channel)

print("wireless top modem initialised on channel", channel)
print("nodeID:", nodeID)
print("---------------------------------------------------")
print("Ready!")
print("---------------------------------------------------")
print("  ")
while true do
    senderID, message, protocol = rednet.receive()
    print("["+senderID+":"+protocol"]", message)
end
