modem = peripheral.wrap("left")
modem.open(69)
rednet.open("left")

print("  ")
write("Distance > ")
distance = read()

rednet.broadcast(distance, "tunnel")

