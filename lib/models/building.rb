class Building
	attr_reader :x, :y, :width, :height

	def initialize(window, x: 0, y: 0, width: 0, height: 0, color: Gosu::Color::GRAY, z: 0, mode: :default)
		@window = window
		@x = x
		@y = y
		@width = width
		@height = height
		@color = color
		@z = z
		@mode = mode
	end

	def update
	end

	def draw
		Gosu.draw_rect(@x, @y, @width, @height, @color, @z, @mode)
	end
end