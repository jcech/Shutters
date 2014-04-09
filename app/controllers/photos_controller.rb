class PhotosController < ApplicationController

  before_filter :authorize, only: [:new, :show, :index]

  def index
    if params[:tagged]
      @photos = Photo.tagged(current_user.id)
    else
      @photos = Photo.where(:user_id => current_user.id)
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to root_url, notice: "Photo deleted!"
  end

  def create
    @photo = Photo.new(user_params)
    if @photo.save
      redirect_to root_url, notice: "Nice Photo!"
    else
      flash.now.alert = "No photo Selected"
      render('new')
    end
  end

  private

  def user_params
    params.require(:photo).permit(:user_id, :image)
  end
end
