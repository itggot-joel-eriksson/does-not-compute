class DoesNotComputeGame < Gosu::Window
    def initialize
        super 1600, 900, true

        self.caption = "Does Not Compute"
    end

    def update

    end

    def draw

    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

game_window = DoesNotComputeGame.new
game_window.show
