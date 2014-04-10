require 'spec_helper'

describe Favorite do
  it { should belong_to :photo }
  it { should belong_to :user }

  describe '#exists' do
    it 'returns a favorite relationship for a given photo_id and user_id' do
      guy = create(:user)
      pic = create(:photo, :user_id => guy.id)
      tag = create(:favorite, :user_id => guy.id, :photo_id => pic.id)
      Favorite.exists(pic.id, guy.id).should eq tag
    end
    it 'returns nil if no favorite exists for a given photo_id and user_id' do
      guy = create(:user, :username => "Bob")
      pic = create(:photo, :user_id => guy.id)
      tag = create(:favorite, :photo_id => pic.id)
      Favorite.exists(pic.id, guy.id).should eq nil
    end
  end
end
