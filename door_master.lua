while true do

  term.clear()
  term.setCursorPos(1,1)
  rednet.open("back")
  
  print("Door Control")
  print("============")
  print()
  
  write("ID > ")
  pass = read("*")
  print()
  
  if pass == "6778" then
    
    print("local : access granted")
    print()
    
    rednet.broadcast("45536", "door_control")
    print("rednet : broadcast master key *****")
    
    senderID, message, protocol = rednet.receive("door_control", 5)
    
    if message == nil then
      
      print("rednet : timeout")
      sleep(3)
      
    else
      
      print(senderID, ":", message)
      sleep(15)
      
    end
  
  else
  
    print("local : access denied")
    sleep(5)
  
  end
  
end