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

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns that review value' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 3)
        expect(restaurant.average_rating).to eq 3
      end
    end

    context 'multiple reviews' do
      it 'provides the average of multiple reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 1)
        restaurant.reviews.create(rating: 5)
        expect(restaurant.average_rating).to eq 3
      end
    end
  end
end
