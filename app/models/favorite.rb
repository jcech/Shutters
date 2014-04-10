class Favorite < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user

  def self.exists(photo_id, user_id)
    Favorite.where(:photo_id => photo_id, :user_id => user_id).first
  end
end
