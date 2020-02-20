modem = peripheral.wrap("back")
modem.open(8)
  
rednet.open("back")

term.clear()
term.setCursorPos(1,1)

print("Wireless Redstone Block v1")
print("-----------------------")
print()

while true do
  
  senderID, message, protocol = rednet.receive("activation")
  
  if message == nil then
  
    print("rednet : interferance logged")
    print()
    
  else
  
    print(senderID, ":", message)
    print()
    
    redstone.setAnalogOutput("left", 15)
    redstone.setAnalogOutput("right", 15)
    redstone.setAnalogOutput("top", 15)
    redstone.setAnalogOutput("bottom", 15)
    redstone.setAnalogOutput("front", 15)
    redstone.setAnalogOutput("back", 15)
    
    print("local : all redstone sides at 15")
    
  end
  
end
