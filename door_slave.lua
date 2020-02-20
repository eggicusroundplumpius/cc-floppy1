print("Door Control Slave Node v1.1")
print()

redstone.setAnalogOutput("front", 15)

rednet.open("top")

while true do
  
  senderID, message, protocol = rednet.receive("door_control")
  
  if message == "45536" then
  
    print(senderID, ":", message)
    print()
    
    redstone.setAnalogOutput("front", 0)
    
    print("local : redstone front at 0")
    print()
    
    rednet.broadcast("door open", "door_control")
    print("rednet : door open")
    print()
    
    sleep(15)
    
    redstone.setAnalogOutput("front", 15)
    
    print("local : redstone at front 15")
    print()
    
    rednet.broadcast("door closed", "door_control")
    print("rednet : door closed")
    print()
    
  end
  
end