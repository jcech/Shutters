class Photo < ActiveRecord::Base
  has_many :favorites
  has_many :tags
  belongs_to :user
  validates :image, :presence => true

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/system/#{Rails.env}/:id/:style/:basename.:extension",
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

  end
end
