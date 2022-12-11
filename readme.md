# Self Extracting Archive for ComputerCraft
Generates a self-extracting version of a vgz file
usage `mksea <archive> <output> <compressed> [output folder name] [Overwrite/Merge]`
`archive` and `output` are files denoting input/output files
`compressed` is a boolean indicating whether the input is compressed
`output folder name` is the folder the SEA will extract to (defaults to output minus extensions)
`Overwrite/Merge` the option for what to do if output folder allready exists defauts to Overwrite

(LD.lua is a stripped+minified [LibDeflate](https://github.com/MCJack123/CC-Archive#libdeflate))

also uses
https://github.com/squeek502/lua-arbitrary-binary-string/blob/master/arbitrary-binary-string.lua
to properlly embed the data within the file