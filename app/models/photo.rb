class Photo < ActiveRecord::Base
  has_many :favorites
  has_many :tags
  belongs_to :user
  validates :image, :presence => true

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/system/#{Rails.env}/:id/:style/:basename.:extension",
                    :url => "/system/#{Rails.env}/:id/:style/:basename.:extension",
                    :default_url => "/images/:style/missing.png"
                    validates_attachment_content_type :image,
                    :content_type => /\Aimage\/.*\Z/

  def self.tagged(user_id)
    photos = []
    Tag.where(:user_id => user_id).each do |tag|
      photos << tag.photo
    end
    photos
  end

  def self.favorited(user_id)
    photos = []
    Favorite.where(:user_id => user_id).each do |favorite|
      photos << favorite.photo
    end
    photos
  end

  def self.recommended(user_id)
    favorite_recommendations = self.favorite_recommended(user_id)
    user_recommendations = self.user_photos_recommended(user_id)

    favorite_recommendations + user_recommendations
  end

  private

  def self.user_photos_recommended(user_id)
    user_photos = User.find(user_id).photos
    friends = self.get_friends(user_photos, user_id)

    photos = self.get_friends_pictures(friends)

    photos - user_photos
  end

  def self.favorite_recommended(user_id)
    photos = []
    favorites = self.favorited(user_id)
    friends = self.get_friends(favorites, user_id)

    friends.each do |friend|
      self.tagged(friend.id).each do |photo|
        photos << photo
      end
    end
    photos - favorites
  end

  def self.get_friends_pictures(friends)
    photos = []
    friends.each do |friend|
      self.tagged(friend.id).each do |photo|
        photos << photo
      end
    end
    photos
  end

  def self.get_friends(pictures, user_id)
    friends = []

    pictures.each do |picture|
      picture.tags.each do |tag|
        friends << tag.user
      end
    end
    friends - [User.find(user_id)]
  end
end
