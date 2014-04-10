require 'spec_helper'
require 'pry'
describe Photo do
  it { should have_many :tags }
  it { should belong_to :user }
  it { should have_many :favorites }

  describe '.tagged' do
    it 'will return all photos where user is tagged' do
      user = create(:user, :username => "Bob")
      photo = create(:photo, :user_id => user.id)
      photo2 = create(:photo)
      tag = create(:tag, :user_id => user.id, :photo_id => photo2.id)
      Photo.tagged(user.id).should eq [photo2]
    end
  end
  describe '.favorited' do
    it 'will return all photos that were favorited by the current user' do
      user = create(:user, :username => "Will")
      photo = create(:photo, :user_id => user.id)
      photo2 = create(:photo)
      favorite = create(:favorite, :user_id => user.id, :photo_id => photo.id)
      Photo.favorited(user.id).should eq [photo]
    end
  end
end
