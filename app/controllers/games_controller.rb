class GamesController < ApplicationController
  def index
    active_game = Game.active.take
    if active_game.present?
      redirect_to active_game
    else
      @games = Game.finished
    end
  end

  def create
    service = ::Games::CreateService.new
    service.call(params: game_params) do |m|
      m.success do |object|
        redirect_to game_path(object.id)
      end

      m.failure do |errors|
        flash[:notice] = errors
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def show
  end
  
  private
  
  def game_params
    params.require(:game).permit(:score)
  end
end
