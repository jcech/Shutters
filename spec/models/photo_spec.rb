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
      user3 = create(:user, :username => "Harold's Mother")
      photo1 = create(:photo, :user_id => user3.id)
      photo2 = create(:photo, :user_id => user3.id)
      photo3 = create(:photo, :user_id => user3.id)
      favorite = create(:favorite, :user_id => user1.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo2.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo3.id)
      Photo.recommended(user1.id).should eq [photo2, photo3]
    end

    it 'will return all photos tagged with users who are also tagged in pics the user has created' do
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

    it 'will return all photos tagged with users who are also in pics the user was tagged in' do
      user1 = create(:user, :username => "Harold")
      user2 = create(:user, :username => "Raekwon")
      photo1 = create(:photo, :user_id => user1.id)
      photo2 = create(:photo, :user_id => user2.id)
      photo3 = create(:photo, :user_id => user2.id)

      tag = create(:tag, :user_id => user2.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user1.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo2.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo3.id)
      Photo.recommended(user1.id).should eq [photo2, photo3]
    end

    it 'will return a mixture of all three types of photos' do
      user1 = create(:user, :username => "Harold")
      user2 = create(:user, :username => "Raekwon")
      user3 = create(:user, :username => "Charles Barkley")
      user4 = create(:user, :username => "Ernie Johnson")

      # Favorites pass
      photo1 = create(:photo, :user_id => user2.id)
      photo2 = create(:photo, :user_id => user2.id)
      favorite = create(:favorite, :user_id => user1.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo1.id)
      tag = create(:tag, :user_id => user2.id, :photo_id => photo2.id)

      #users' pass
      photo3 = create(:photo, :user_id => user1.id)
      photo4 = create(:photo, :user_id => user3.id)
      tag = create(:tag, :user_id => user3.id, :photo_id => photo3.id)
      tag = create(:tag, :user_id => user3.id, :photo_id => photo4.id)

      #tags pass
      photo5 = create(:photo, :user_id => user4.id)
      photo6 = create(:photo, :user_id => user4.id)
      tag = create(:tag, :user_id => user1.id, :photo_id => photo5.id)
      tag = create(:tag, :user_id => user4.id, :photo_id => photo5.id)
      tag = create(:tag, :user_id => user4.id, :photo_id => photo6.id)

      Photo.recommended(user1.id).should eq [photo2, photo4, photo6]

    end
  end
end
