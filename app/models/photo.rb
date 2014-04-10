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
    tagged_recommendations = self.tagged_recommended(user_id)

    (favorite_recommendations + user_recommendations + tagged_recommendations).uniq
  end

  private

  def self.tagged_recommended(user_id)
    tagged_photos = self.tagged(user_id)
    photos = self.get_friends_pictures(self.get_friends(tagged_photos, user_id))

    photos - tagged_photos
  end

  def self.user_photos_recommended(user_id)
    user_photos = User.find(user_id).photos
    photos = self.get_friends_pictures(self.get_friends(user_photos, user_id))

    photos - user_photos
  end

  def self.favorite_recommended(user_id)
    favorites = self.favorited(user_id)
    photos = self.get_friends_pictures(self.get_friends(favorites, user_id))

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
