--Comm Center Interface Program: Configure with Advanced Monitor on top, 
--Wired modem on bottom. Part A of Comm Center Package.

--Functions


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
    intralink_channel = toNumber(config.readLine())
    print("intralink channel is", intralink_channel)
    
    print("  ")
    config.close()
else
    print("config not found! using defaults..")
    print("  ")
	
	--Default Config Parameters (should reflect custom configs)
    interlink_channel = 1
    print("intralink channel:", intralink_channel)
    
    print("  ")
end

--Intralink Modem Detection and Initialisation
isconnected = peripheral.isPresent("bottom")
if isconnected then
    print("detected peripheral on bottom")
    ismodem = peripheral.getType("bottom")
    if ismodem == "modem" then
        print("modem found")
        intralink = peripheral.wrap("bottom")
        intralink.open(intralink_channel)
        print("intralink open")
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
print("Pathos III Comm Interface")
print("---------------------------")
print("  ")

