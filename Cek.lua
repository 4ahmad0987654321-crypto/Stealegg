-- Debug: Cek isi karakter lu
local char = game.Players.LocalPlayer.Character
print("=== ISI KARAKTER ===")
for _, obj in pairs(char:GetChildren()) do
    print("Child:", obj.Name, "| Class:", obj.ClassName)
end

print("=== ISI HumanoidRootPart ===")
local hrp = char:FindFirstChild("HumanoidRootPart")
if hrp then
    for _, obj in pairs(hrp:GetChildren()) do
        print("Child:", obj.Name, "| Class:", obj.ClassName)
    end
end
