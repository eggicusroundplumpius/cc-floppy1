modem = peripheral.wrap("left")
modem.open(69)

rednet.open("left")

while true do
    senderID, message, protocol = rednet.receive("tunnel")
    print("[", senderID, ":", protocol, "]", message)
    shell.run("tunnel", message)
    print("  ")
    print("operation complete.")
    print("  ")
end
