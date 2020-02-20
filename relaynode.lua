last_senderID = nil
last_message = nil
last_protocol = nil
last_time = 0

term.clear()
term.setCursorPos(1,1)
print("Relay Node v1.3")
print("---------------")
print()

isfront = peripheral.isPresent("front")

if isfront then  

  modem = peripheral.wrap("front")
  modem.open(8)

  print("rednet : initializing")
  print()

  rednet.open("front")

else

  modem = peripheral.wrap("bottom")
  modem.open(8)
  
  print("rednet : initializing")
  print()  

  rednet.open("bottom")
      
end

redstone.setAnalogOutput("top", 15)
print("local : ready!")
print()

while true do

  senderID, message, protocol = rednet.receive()
  
  time = os.time()
  
  print("["..time.."]", senderID, ":", message)
  print()
  
  sleep(0.1)
  
  if last_message ~= message and last_protocol ~= protocol then
  
    print("local : relaying...")
    print()
  
    rednet.broadcast(message, protocol)
    
    sleep(0.5)
    
    print("local : message relayed on", protocol, "protocol.")
    print()
  
    last_senderID = senderID
    last_message = message
    last_protocol = protocol
    last_time = time
  
  else
    
    print("local : repeat message detected. ignoring...")
    
    last_senderID = nil
    last_message = nil
    last_protocol = nil
    last_time = 0
    
  end
  
end
