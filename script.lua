local filename = app.params["filename"]
local spriteSheet = app.open(filename)

if not spriteSheet then
  error("Failed to open sprite sheet.")
end

local frameWidth = 48
local frameHeight = 64
local paddingy = 0
local paddingx = 0


local columns = spriteSheet.width // frameWidth
local rows = spriteSheet.height // frameHeight
local layer = spriteSheet.layers[1]
local cel = layer:cel(1)

if not cel or not cel.image then
  error("No image found in the first cel.")
end


local fullImage = cel.image
local newSprite = Sprite(frameWidth, frameHeight, spriteSheet.colorMode)
local newLayer = newSprite.layers[1]


local current = 1
for row = 0, rows - 1 do
  for col = 0, columns - 1 do
    local x = (col * (frameWidth +paddingx))
    local y = (row * (frameHeight+paddingy))
	

	local frame
	if current == 1 then
		frame = newSprite.frames[1]
	else
		frame = newSprite:newEmptyFrame()
	end
	
    local cel = newSprite:newCel(newLayer, frame, fullImage, Point(-x, -y))
    if not cel then error("Failed to create cel") end
	current = current + 1

  end
end

local outPath = "/export/" .. app.fs.filePath(filename) .. "/" .. app.fs.fileTitle(filename) .. ".aseprite"
newSprite:saveCopyAs(outPath)
