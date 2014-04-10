class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_secure_password
  has_many :photos
  has_many :tags
  has_many :favorites

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/system/avatars/#{Rails.env}/:id/:style/:basename.:extension",
                    :url => "/system/avatars/#{Rails.env}/:id/:style/:basename.:extension",
                    :default_url => "/system/avatars/billmurray.gif"
                    validates_attachment_content_type :avatar,
                    :content_type => /\Aimage\/.*\Z/

end
