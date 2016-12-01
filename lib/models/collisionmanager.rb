class CollisionManager
	attr_reader :top, :right, :bottom, :left

	def initialize(player, buildings, players)
		@player = player
		@buildings = buildings
		@players = players
	end

	def check_for_collisions
		@buildings.each do |building|
			@player.collides_with(building)
		end
	end

	def self.left
		return 45..134
	end

	def self.right
		return 135..224
	end

	def self.bottom
		return 225..314
	end

	# def self.left
	# 	return 315..359 and 0..44
	# end
end
