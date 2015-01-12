require 'image_suckr'
require 'RMagick'
include Magick

print 'Game: '
game = gets

suckr = ImageSuckr::GoogleSuckr.new

bg_url = suckr.get_image_url({'q' => "#{game} screenshot"})

bg = ImageList.new(bg_url)[0]

bg.resize_to_fill!(460,215)

text_container = Magick::Image.read("label:#{game}") {
    self.stroke = '#000000'
    self.fill = '#ffffff'
    self.size = "#{440}x#{195}"
    self.background_color = 'transparent'
}.first

image = bg.composite(text_container, 10, 10, Magick::OverCompositeOp)

image.display
image.write("samples/#{game.gsub(' ','.')}.png")
