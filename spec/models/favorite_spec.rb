require 'spec_helper'

describe Favorite do
  it { should belong_to :photo }
  it { should belong_to :user }
end
