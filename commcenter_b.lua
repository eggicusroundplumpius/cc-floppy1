--Comm Center Transmitter Program: Configure with Wireless Modem on top, 
--Wired modem on back. Part B of Comm Center Package.

--Functions
function listen ()
	local senderID, message, protocol = rednet.recieve(protocol)
	local part1, part2, currentpart
	for i in message do
		if i == ":" then
			currentpart = 2
		elseif currentpart == 1 then
			part1 = part1 + i
		elseif currentpart == 2 then
			part2 = part2 + i
		end
	end
	--Returns message task, message content, sender ID
	return part1, part2, senderID
end
function lookup (host)
    local result = rednet.lookup(protocol, host)
    if result then
		--Returns Computer ID from lookup and a boolean to represent success
        return result, true
    else
        return nil, false
    end
end
function ping (hostID, kind, timeout)
	local message = "ping:" + kind
	rednet.send(hostID, message, protocol)
	if timeout then
		local senderID, reply, reply_protocol = rednet.recieve(protocol, timeout)
	else
		local senderID, reply, reply_protocol = rednet.recieve(protocol, 5)
	end
	while true do
		local part1, part2, currentpart
		for i in reply do
			if i == ":" then
				currentpart = 2
			elseif currentpart == 1 then
				part1 = part1 + i
			elseif currentpart == 2 then
				part2 = part2 + i
			end
		end
		if part1 == "ping" then
			break
		end
	end
	--Returns Computer ID, reply and ping truth
	if part1 then
		return senderID, part2, true
	else
		return nil, nil, false
	end
end
function establish (site)
	local chatname = protocol+"/"+hostname+"-"+site
	shell.run("chat host", chatname, hostname)
	intralink.transmit(intralink_channel, intralink_channel, chatname)
end
function forwardMode ()
	while true do
		local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
		if message == "intralink:disconnect" and modemSide == "back" then
			break
		else
			wireless.transmit(senderChannel, replyChannel, message)
		end
	end
	os.reboot()
end
function switchProtocol (p)
    protocol = p
    print("default protocol is now", protocol)
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
    intralink_channel = 1
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

print("---------------------------------------------------")
print("Pathos III Comm Transmitter")
print("---------------------------------------------------")

while true do
	task, message, ID = listen()
	print("["+ID+"]", task, "'"+message+"'")
	--Task List for Intralink Commands
	if source == "intralink" then
		
		--Establish Local-Remote Chat
		if task == "establish" then
			ID, valid = lookup(message)
			if valid then
				ID, message, truth = ping(ID, 0, 5)
				if truth then
					print("["+task+"]", ID+"/"+message)
					establish(mesaage)
				else
					print("[system] ping timeout, target comm must be offline")
				end
			else
				print("[system] lookup failed, target comm may not exist")
			end
		end
		
		--Realign Comm to New Protocol
		if task == "switch_protocol" then
			switchProtocol(message)
		end
		
		--Send Ping Command
		if task == "ping" then
			ID, truth = lookup(message)
			replyID, content, valid1 = ping(ID, 0, 5)
			if valid1 then
				intralink.transmit(intralink_channel, intralink_channel, replyID+":"+content)
			else
				intralink.transmit(intralink_channel, intralink_channel, false)
			end
		end
		
		--Lookup ID
		if task == "lookup" then
			ID, trueness = lookup(message)
			if trueness then
				intralink.transmit(intralink_channel, intralink_channel, ID)
			else
				intralink.transmit(intralink_channel, intralink_channel, false)
			end
		end
		
	--Task List for Remote Commands
	elseif source == "wireless" then
	
		--Connect to Remote-Local Chat
		if task == "chat" then
			intralink.transmit(intralink_channel, intralink_channel, message)
			forwardMode()
		end
		
		--Ping Reply
		if task == "ping" then
			if message == "0" then
				rednet.send(ID, "ping:hello_world", broadcast)
			elseif message == "1" then
				print("[system] no reply to ping, type 1")
			elseif message == "2" then
				print("[system] ping type 2, sending intralink notif")
				intralink.transmit(intralink_channel, intralink_channel, "ping:"+ID)
				rednet.send(ID, "ping:hello_world", ID)
			end
		end

	end
end