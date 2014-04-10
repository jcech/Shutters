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

  describe '.recommended' do
    it 'will return all photos tagged with users who are also in pics the user has favorited' do
      user1 = create(:user, :username => "Harold")
      user2 = create(:user, :username => "Raekwon")
      photo1 = create(:photo, :user_id => user1.id)
      photo2 = create(:photo, :user_id => user1.id)
      photo3 = create(:photo, :user_id => user1.id)
      favorite = create(:favorite, :user_id => user1.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo2.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo3.id)
      Photo.recommended(user1.id).should eq [photo2, photo3]
    end

    it 'will return all photos tagged with users who are also in pics the user has created' do
      user1 = create(:user, :username => "Harold")
      user2 = create(:user, :username => "Raekwon")
      photo1 = create(:photo, :user_id => user1.id)
      photo2 = create(:photo, :user_id => user2.id)
      photo3 = create(:photo, :user_id => user2.id)

      tag = create(:tag, :user_id => user2.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo2.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo3.id)
      Photo.recommended(user1.id).should eq [photo2, photo3]
    end
  end
end
