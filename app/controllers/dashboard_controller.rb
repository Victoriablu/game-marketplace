class DashboardController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @games = Game.where(user_id: current_user.id)
    end
end
