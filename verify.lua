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

local o = ... and shell.resolve(...) or nil
if o and (not fs.exists(o)) or true then
    print("verify.lua - VGZ and SEA archive verifier")
    print("Usage:")
    print("verify <archive>")
    print("where <archive> is a VGZ/SEA archive")
    print("this program will print what part of decompress fails")
    return
end

local h = fs.open(o,'rb')
local content = h.readAll()h.close()
local data = content:match("%[===%[(.+)%]===%]") or content --extract from SEA or assume vgz
print("content bytes:",#data)
local decode = ld:d(data)
if not decode then
    print("unnable to decompress GZIP data, is it a VGZ/SEA")
    return
end
local t = textutils.unserialise(decode)
if not t then
    print("Archive is corrupted (could not decode table)")
elseif type(t) ~= "table" then
    print("Archive is corrupted (decompressed data is not a table)")
else
    print("Archive is valid")
end
