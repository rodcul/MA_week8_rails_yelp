require 'spec_helper'
require 'rails_helper'

describe Restaurant, type: :model do
  it{is_expected.to have_many :reviews}

  it "is not valid with a name less than 3 characters" do
    restaurant = Restaurant.new(name: 'Mc')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid if the restaurant already exists" do
    Restaurant.create(name: 'MaccyDs')
    restaurant = Restaurant.new(name: 'MaccyDs')
    expect(restaurant).to have(1).error_on(:name)
  end
end