local d = shell.getRunningProgram()
local sc = require "cc.shell.completion"

local pdir = fs.getDir(shell.getRunningProgram())
package.path = package.path .. ";/" .. pdir .. "/?.lua;/" .. pdir .."/?;" .. pdir .. "?"

local loaded_ld, ld = pcall(require, "LD")

if not shell.getCompletionInfo()[d] then
    shell.setCompletionFunction(d,sc.build(
        sc.file
    ))
end

if not loaded_ld then
    error("failed to load stripped LibDeflate: "..ld)
end

local o = shell.resolve(...)
if not fs.exists(o) then
    error("input file does not exists")
end

local h = fs.open(o,'rb')
local content = h.readAll()h.close()
local data = content:match("%[===%[(.+)%]===%]") or content
print(#data)
local d = ld:d(data)
print(#d)
local t = textutils.unserialise(d)
print(d)