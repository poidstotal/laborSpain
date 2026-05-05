function Image(img)
  if img.src:match('%.pdf$') then
    local png = img.src:gsub('%.pdf$', '.png')
    local f = io.open(png, 'r')
    if f ~= nil then
      f:close()
      img.src = png
    end
  end
  return img
end
