yn = "Y"

term.clear()
term.setCursorPos(1,1)

print("Software Update v1.1")
print("------------------")
print()

write("Destination File Path > ")
dpath = read()
print()

istrue1 = fs.exists(dpath)

if istrue1 == false then
  
  print("No path or file exists at this location. Proceed?")
  print()
  write("Y/N > ")
  yn = read()

end

if yn == "Y" or yn == "y" then

  write("Update Package Path > ")
  upath = read()
  print()
  
  istrue2 = fs.exists(upath)
  
  if istrue2 then
  
    print("Commencing Update...")
    print()
    
    sleep(1)
    
    fs.delete(dpath)
    fs.copy(upath, dpath)
    
    print("Operation Complete,")
    print()
    sleep(1)
    os.reboot()
  
  else
  
    print("No such path or file")
    print()
    
  end
  
end
