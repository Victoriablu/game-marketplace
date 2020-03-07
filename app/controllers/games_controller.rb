class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @games = Game.search(params[:search])
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user

    if @game.save
      redirect_to @game, notice: 'Game was successfully listed.'
    else
      render :new
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

    def authorize_user!
      return true if current_user == @game.user

      flash[:notice] = "You are not permitted to change that listing."
      redirect_to "/"

      return false
    end
end
