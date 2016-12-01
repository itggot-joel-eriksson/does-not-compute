class Player
	attr_reader :x, :y, :width, :height

	def initialize(x: nil, y: nil, window:, vehicle:)
		@window = window
		@vehicle = vehicle
		@drawing = @vehicle.straight

		@width = vehicle.width
		@height = vehicle.height

		@x = x == nil ? (@window.width / 2) - (@vehicle.straight.width / 2) : x
		@y = y == nil ? (@window.height / 2) - (@vehicle.straight.height / 2) : y

		@vel_x = @vel_y = @angle = 0.0
	end

	def turn_left
		@angle, @drawing = @vehicle.turn_left
	end

	def turn_right
		@angle, @drawing = @vehicle.turn_right
	end

	def set_straight
		@drawing = @vehicle.straight
	end

	def accelerate
		@vel_xy = @vehicle.accelerate

		@vel_x = @vel_xy.first
		@vel_y = @vel_xy.last
	end

	def crash!
		@vehicle.crash!
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= @window.width
		@y %= @window.height
	end

	def translate(x:, y:)
		@x += x
		@y += y
	end

	def draw
		@drawing.draw_rot(@x, @y, 1, @angle, 0.5, 0.5, 1, 1, Gosu::Color::WHITE, :default)
	end

	def collides_with(building)
		collided_x = (building.x..(building.width + building.x)).include?(self.x)
		collided_y = (building.y..(building.height + building.y)).include?(self.y)

		if collided_x && collided_y
			self.crash!

			if CollisionManager.left.include?(@angle) # Collided from right facing left
				translate(x: ((building.x + building.width) / 2), y: 0) # Move vehicle right
			elsif CollisionManager.right.include?(@angle) # Collided left facing right
				translate(x: ((building.x + building.width) / 2) * -1, y: 0) # Move vehicle left
			elsif CollisionManager.bottom.include?(@angle) # Collided from top facing downwards
				translate(x: 0, y: ((building.y + building.height) / 2) * -1) # Move vehicle down
			else # Collided from bottom facing upward
				translate(x: 0, y: ((building.y + building.height) / 2)) # Move vehicle up
			end
		end
	end
end
