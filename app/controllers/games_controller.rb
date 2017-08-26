class GamesController < ApplicationController
  def index
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
    game = Game.find(params[:id])
    if game.finished?
      @winner = game.winner
    else
      @current_round = game.current_round
      @user_rounds = game.rounds.group_by(&:user)
      @current_player = @current_round.user
    end
  end

  private

  def game_params
    params.require(:game).permit(:score)
  end

  def active_game
    Game.active.take
  end
end
