isnetwork = false

istop = peripheral.isPresent("top")
if istop then
    toptype = peripheral.getType("top")
    if toptype == "modem" then
        isnetwork = true
    end
end
isback = peripheral.isPresent("back")
if isback then
    backtype = peripheral.getType("back")
    if backtype == "modem" then
        isnetwork = true
    end
end

if isnetwork then
    print("---------------------------------------------------")
    print("WARNING: This terminal is networked. Mounted drives and peripherals are exposed to the network.")
    print("---------------------------------------------------")
end

shell.run("rednet_listener")
