class RoundsController < ApplicationController
  def update
    round = Round.find(params[:id])
    service = ::Rounds::UpdateService.new
    service.call(params: params.merge(id: round.id)) do |m|
      m.success do |object|
        redirect_to game_path(object.game.id)
      end

      m.failure do |errors|
        flash[:notice] = errors
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
