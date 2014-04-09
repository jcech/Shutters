require 'spec_helper'

describe Tag do
  it { should belong_to :photo }
  it { should belong_to :user }
end
