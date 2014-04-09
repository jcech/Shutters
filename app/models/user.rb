class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_secure_password
  has_many :photos
  has_many :tags

end
