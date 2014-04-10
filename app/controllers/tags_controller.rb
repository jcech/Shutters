class TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to photo_path(params[:tag][:photo_id]), notice: "#{User.find(params[:tag][:user_id]).username} was tagged to the photo"
    else
      redirect_to :back, alert: "Don't be silly and pick a person"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:user_id, :photo_id)
  end
end
