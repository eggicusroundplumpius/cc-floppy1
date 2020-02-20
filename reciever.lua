modem = peripheral.wrap("right")
modem.open(445)

rednet.open("right")

print("Reactor Control Receiver Program v1.2")
print("")

while true do

  senderID, message, protocol = rednet.receive("reactor_control")
  
  print(senderID, ":", message)
  print("")
  
  if message == "az5" then
  
    redstone.setAnalogOutput("left", 0)
    
    print("local : EMERGANCY SHUT DOWN")
    print("")
    
    rednet.send(senderID, "EMERGANCY SHUTDOWN", "reactor_control")
  
  elseif message == "activate1" then
  
    redstone.setAnalogOutput("left", 15)
    
    print("local : redstone left at 15")
    print("local : reactor active")
    print("")
    
    rednet.send(senderID, "reactor active", "reactor_control")
  
  elseif message == "deactivate1" then
  
    redstone.setAnalogOutput("left", 0)
    
    print("local : redstone left at 0")
    print("local : reactor inactive")
    print("")
    
    rednet.send(senderID, "reactor inactive", "reactor_control")
  
  end
  
end
