class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      redirect_to photo_path(params[:favorite][:photo_id])
    else
      redirect_to :back, alert: "You must be a wizard to break this!"
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :photo_id)
  end
end
