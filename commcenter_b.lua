--Comm Center Transmitter Program: Configure with Wireless Modem on top, 
--Wired modem on back. Part B of Comm Center Package.

--Functions
function ping (host)
    local result = rednet.lookup(protocol, host)
    if result then
        return result, true
    else
        return nil
    end
end
function addProtocol (p)
    rednet.host(p, hostname)
    print(p, "protocol now hosting")
end
function removeProtocol (p)
    rednet.unhost(p, hostname)
    print(p, "protocol discontinued")
end
function switchProtocol (p)
    protocol = p
    print("default protocol is now", protocol)
end
function establish (s)
    local id, result = ping(s)
    if result then
        print("conection to", s, "success!")
        local chatname = protocol+"/"+hostname+"-"+s
        os.run("chat host", chatname, hostname)
		intralink.transmit(intralin_channel, intralink_channel, chatname)
	end
end
function listen ()
	local senderID, message, protocol = rednet.recieve(protocol)
	
	if message
	
end

--Detect and load Config file
term.clear()
term.setCursorPos(1,1)
print("Config Importer")
print("---------------------------------------------------")
print(" ")
isconfig = fs.exists("config.txt")
if isconfig then
    print("config found!")
    config = fs.open("config.txt", "r")
    
	--Custom Config Parameters
    hostname = config.readLine()
    print("hostname is", hostname)
    protocol = config.readLine()
    print("default protocol is", protocol)
    intralink_channel = toNumber(config.readLine())
    print("intralink channel is", intralink_channel)
    
    print("  ")
    config.close()
else
    print("config not found! using defaults..")
    print("  ")
	
	--Default Config Parameters (should reflect custom configs)
    hostname = "unknown_host"
    print("hostname:", hostname)
    protocol = "new_link"
    print("default protocol:", protocol)
    interlink_channel = 1
    print("intralink channel:", intralink_channel)
    
    print("  ")
end

--Wireless Modem Detection and Initialisation
isconnected = peripheral.isPresent("top")
if isconnected then
    print("detected peripheral on top")
    ismodem = peripheral.getType("top")
    if ismodem == "modem" then
        print("modem found")
        wireless = peripheral.wrap("top")
        rednet.open("top")
        print("rednet open!")
        print("  ")
        rednet.host(protocol, hostname)
        print("hosting", protocol, "with hostname", hostname)
        print("  ")
        sleep(3)
	end
else
	print("FATAL ERROR: No Wireless Modem Detected.")
	print("  ")
	print("Press Any Key to Reboot")
	event, key, isHeld = os.pullEvent("key")
	os.reboot()
end

--Intralink Modem Detection and Initialisation
isconnected = peripheral.isPresent("back")
if isconnected then
    print("detected peripheral on back")
    ismodem = peripheral.getType("back")
    if ismodem == "modem" then
        print("modem found")
        intralink = peripheral.wrap("back")
        intralink.open(intralink_channel)
        print("rednet open!")
        print("  ")
        sleep(3)
	end
else
	print("FATAL ERROR: No Intralink Modem Detected.")
	print("  ")
	print("Press Any Key to Reboot")
	event, key, isHeld = os.pullEvent("key")
	os.reboot()
end

print("--------------------------------")
print("Ready!")
print("--------------------------------")
print("  ")
sleep(1)

--Main Program

term.clear()
term.setCursorPos(0,0)

print("---------------------------")
print("Pathos III Comm Transmitter")
print("---------------------------")


