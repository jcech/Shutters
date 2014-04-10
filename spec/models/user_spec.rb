require 'spec_helper'

describe User do
  it 'should require unique username' do
    user1 = create(:user, :username => "Bob")
    user2 = build(:user, :username => "Bob")
    user2.save.should eq false
  end

  it { should have_many :favorites }
  it { should have_many :photos }
  it { should have_many :tags }
end
