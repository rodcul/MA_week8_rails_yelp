require 'rails_helper'
# require "rack/test"
#
# describe APIV1 do
#   def app
#     Rails.application
#   end
#
#   describe APIV1 do
#     include Rack::Test::Methods
# #
#     before do
#       Restaurant.create(name: "Urthcafe")
#     end
#     describe 'Restaurants' do
#       it 'GET /api/restaurants' do
#         get '/api/restaurants' do
#           last_response.status.should == 200
#           JSON.parse(last_response.body)[:name]  == "Urthcafe"
#         end
#       end
#
#     end
#
# end
#

describe "API" , :type => :api do


  before do
    @restaurant = Restaurant.create(name:'Urthcafe')
    @restaurant.reviews.create(thoughts: 'Fine', rating: 5)
  end

  it "requests restaurants" do
    get "/api/restaurants",:formate =>:json
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['name']).to eq('Urthcafe')
  end

  it "requests reviews" do
    get "/api/restaurants/#{@restaurant.id}/reviews", :formate =>:json
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['thoughts']).to eq('Fine')
    expect(JSON.parse(last_response.body).first['rating']).to eq(5)
  end

end
