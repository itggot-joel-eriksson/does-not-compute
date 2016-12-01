class DoesNotComputeGame < Gosu::Window
	def initialize
		super Gosu::screen_width - 30, Gosu::screen_height - 30, false

		self.caption = "Does Not Compute"

		@round = 1
		@round_time = 0

		vehicle = Car.new(window: self, speed: 7.0, crashed_speed_multiplier: 1.0, turning: 4.5)
		@player = Player.new(window: self, vehicle: vehicle)
		
		@buildings = [
			Building.new(self, x: 100, y: 100, width: 100, height: 100, color: Gosu::Color::GREEN, z: 1),
			Building.new(self, x: 300, y: 300, width: 100, height: 100, color: Gosu::Color::YELLOW, z: 1)
		]

		@previous_players = []

		@history = [
			[]
		]

		@round = new_round

		@collision_manager = CollisionManager.new(@player, @buildings, @previous_players)
	end

	def update
		unless @round
			return
		end

		# if @history.size > @round_time
		# 	movement = @history[@round_time]

		# 	if movement[2] == "1"
		# 		@player2.turn_left
		# 	end

		# 	if movement[3] == "1"
		# 		@player2.turn_right
		# 	end

		# 	if movement[2] == "0" && movement[3] == "0"
		# 		@player2.set_straight
		# 	end

		# 	@player2.accelerate
		# 	@player2.move
		# end

		steering_left = false
		steering_right = false

		if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
			steering_left = true
		end

		if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
			steering_right = true
		end

		if !steering_left && !steering_right
			@player.set_straight

			@history[@round] << :straight
		elsif steering_left && !steering_right
			@player.turn_left

			@history[@round] << :left
		elsif !steering_left && steering_right
			@player.turn_right

			@history[@round] << :right
		end

		@round_time += 1

		@player.accelerate
		@player.move

		@collision_manager.check_for_collisions
	end

	def new_round
		@previous_players << @player

		round = 0

		if @history.size > 1
			round = @round + 1
			@history << []
		end

		return round
	end

	def draw
		@player.draw

		@buildings.each do |building|
			building.draw
		end

		Gosu.draw_rect(0, 0, self.width, self.height, Gosu::Color::WHITE)
	end

	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
	end
end
