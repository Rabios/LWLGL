dofile("lwlgl.lua")
lwlgl.init()

device = al.alcOpenDevice(nil)
if device then
    print("Audio device initialized!")
else
    print("Audio device failed to initialize!")
end