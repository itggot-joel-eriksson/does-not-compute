# https://www.iconfinder.com/icons/1011025/auto_axle_car_drivetrain_parts_service_tranny_icon#size=64
# https://www.iconfinder.com/icons/1011031/auto_axle_balancing_car_drivetrain_parts_service_icon#size=64

class Car < Player
	attr_reader :straight, :left, :right, :width, :height

	def initialize(window:, speed: 1.0, crashed_speed_multiplier: 0.5, turning: 4.5)
		@window = window

		@color = Gosu::Color::BLACK

		@straight = Gosu::Image.new("./media/images/car.png")
		@left = Gosu::Image.new("./media/images/car_turn-left.png")
		@right = Gosu::Image.new("./media/images/car_turn-right.png")

		@width = @straight.width
		@height = @straight.height

		@vel_x = @vel_y = @angle = 0.0

		@speed = speed
		@crashed_speed_multiplier = crashed_speed_multiplier
		@turning = turning

		@crashed = false
	end

	def turn_left
		@angle -= @turning
		@drawing = @left

		@angle %= 360
		
		[@angle, @drawing]
	end

	def turn_right
		@angle += @turning
		@drawing = @right

		@angle %= 360

		[@angle, @drawing]
	end

	def crash!
		@crashed = true
	end

	def accelerate
		if @crashed
			@vel_x = Gosu::offset_x(@angle, @speed * @crashed_speed_multiplier)
			@vel_y = Gosu::offset_y(@angle, @speed * @crashed_speed_multiplier)
		else
			@vel_x = Gosu::offset_x(@angle, @speed)
			@vel_y = Gosu::offset_y(@angle, @speed)
		end
		
		[@vel_x, @vel_y]
	end

	def update
	end

	def draw
	end
end
