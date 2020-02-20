print("Reactor Control Program v1.0")
print()

modem = peripheral.wrap("back")

if modem == false then

  print("local : modem error")
  print()
  
else

  modem.open(445)
  rednet.open("back")
  
  while true do
    
    write("> ")
    input = read()
    print()
    
    if input == "az5" then
    
      print("local : sending instruction")
      rednet.broadcast("az5", "reactor_control")
      print("rednet : az5")
      print()
      
      senderID, message, protocol = rednet.receive("reactor_control", 5)
      
      if message == nil then
      
        print("rednet : timeout")
        print()
        
      else
      
        print(senderID, ":", message)
        print()
      
      end
    
    elseif input == "activate" then
      
      write("ID > ")
      rid = read()
      print()
        
      print("local : sending instruction")
      rednet.broadcast("activate"..rid, "reactor_control")
      print("rednet : activate"..rid)
      print()
        
      senderID, message, protocol = rednet.receive("reactor_control", 5)
        
      if message == nil then
          
        print("rednet : timeout")
        print()
          
      else
          
        print(senderID, ":", message)
        print()
          
      end
      
    elseif input == "deactivate" then
    
      write("ID > ")
      rid = read()
      print()
      
      print("local : sending instruction")
      rednet.broadcast("deactivate"..rid, "reactor_control")
      print("rednet : deactivate"..rid)
      print()
        
      senderID, message, protocol = rednet.receive("reactor_control", 5)
        
      if message == nil then
          
        print("rednet : timeout")
        print()
          
      else
        
        print(senderID, ":", message)
        print()
          
      end
    
    end
    
  end
  
end