require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid factory' do
    expect( build(:user) ).to be_valid
  end

  it 'requires an email' do
    expect( build(:user, email: nil) ).not_to be_valid
  end
end
