modem = peripheral.wrap("back")
modem.open(8)

rednet.open("back")

print("rednet : open to channel 8")
print()

sleep(3)

for i = 10, 1, -1 do
  print(i)
  sleep(1)
end

print()

rednet.broadcast("activate", "activation")
print("local : activate")
print()