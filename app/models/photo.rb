class Photo < ActiveRecord::Base
  has_many :tags
  belongs_to :user
  validates :image, :presence => true

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
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

end
