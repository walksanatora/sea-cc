local d = shell.getRunningProgram()

if not shell.getCompletionInfo()[d] then
    local sc = require "cc.shell.completion"
    shell.setCompletionFunction(d,sc.build(
        sc.file,
        sc.file,
        {sc.choice, {"true","false"}},
        nil
    ))
end

local args = {...}
if #args < 3 then
    error("insufficent args")
end
local input = shell.resolve(table.remove(args,1))
local output = shell.resolve(table.remove(args,1))
local compressed = table.remove(args,1)

local rcompressed = textutils.unserialise(compressed)
if type(rcompressed) ~= "boolean" then
    error("compression is not a boolean it is "..type(rcompressed))
end
local compressed = rcompressed
local out_name = table.remove(args,1)
if out_name == nil then
    out_name = fs.getName(output):match("(.+)%..+$")
end
if not fs.exists(input) then error("input file does not exists "..input) end
if fs.exists(output) and not settings.get("mksea.overwrite") then
    print("Overwrite output file? <Y/N>")
    local i = read()
    if i ~= "Y" then print("Cancled") return end
end

--now we know that 1. all options are valid
--and that we are OK to overwrite the output (Possibly)

local output_file = fs.open(output,'wb')
if compressed then
    output_file.write('local I,c,o,f,C,t,s,D = table.unpack({\nloadstring([=[')
    local ldh = fs.open(fs.combine(fs.getDir(shell.getRunningProgram()),"LD.lua"),'rb')
    local ldc = ldh.readAll()
    output_file.write(ldc)
    ldh.close()
    output_file.write(']=])()\n,(function()local u,g = fs.open(shell.getRunningProgram(),"rb")g=u.readAll()u.close()return g:match("%[===%[(.+)%]===%]") end)(),shell.resolve(""),fs.open,fs.combine,type,shell.setDir,shell.dir()})\nfunction u(p,z)fs.makeDir(C(o,p))s(C(o,p))for k, v in pairs(z) do if t(v) == "table" then u(p.."/"..k,v)elseif t(v) == "string" then local h = f(fs.combine(o,C(p,k)),"wb")h.write(v)h.close()end end end u("')
    output_file.write(out_name)
    output_file.write('",textutils.unserialise(I:d(c)))s(o)')
    output_file.write('\n--[===[')
    local arh = fs.open(input,"rb")
    output_file.write(arh.readAll())
    arh.close()
    output_file.write(']===]')
else
    output_file.write('local c,o,f,C,t,s,D = table.unpack({\nloadstring((function()local u,g = fs.open(shell.getRunningProgram(),"rb")g=u.readAll()u.close()return g:match("%[===%[(.+)%]===%]") end)(),shell.resolve(""),fs.open,fs.combine,type,shell.setDir,shell.dir()})\nfunction u(p,z)fs.makeDir(C(o,p))s(C(o,p))for k, v in pairs(z) do if t(v) == "table" then u(p.."/"..k,v)elseif t(v) == "string" then local h = f(fs.combine(o,C(p,k)),"wb")h.write(v)h.close()end end end u("')
    output_file.write(out_name)
    output_file.write('",textutils.unserialise(c))s(o)')
    output_file.write('\n--[===[')
    local arh = fs.open(input,"rb")
    output_file.write(arh.readAll())
    arh.close()
    output_file.write(']===]')
end
print("auto_extract: "..out_name)

output_file.close()
