require 'spec_helper'
require 'rails_helper'

describe Review, type: :model do
  it "must have ratings below or equal to 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
