class GamesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_user_game, only: [:show]
  # before_action :set_user_game, only: [:edit, :update, :destroy]

  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    
    if @game.save
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

    def edit
      @game = Game.find(params[:id])
    end

    def update
      @game = Game.find(params[:id])

      if @game.update(game_params)
        redirect_to @game
      else  
        render 'edit'
      end
    end

    def destroy
      game = Game.find(params[:id])
      game.destroy

      redirect_to '/'
    end

    def set_user_game
      id = params[:id]
      @game = current_user.games.find_by_id(id)
  
      if @game == nil
          redirect_to games_path
      end
    end
    
  private
    def game_params
      params.require(:game).permit(:title, :platform, :condition, :description, :price, :picture)
    end

    def set_game
      @game = Game.find(params[:id])
    end

    def authorize_owner
      return true if @game.user == current_user

      flash[:notice] = "You are not permitted to change that listing."
      redirect_to "/"

      return false
    end
end
