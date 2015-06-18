require 'rails_helper'
# require "rack/test"
#
# describe Restaurantapi do
#   def app
#     Rails.application
#   end
#
#   describe Restaurantapi do
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
    Restaurant.create(name:'Urthcafe')
  end

  it "request restaurants" do
    get "/api/restaurants",:formate =>:json
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['name']).to eq('Urthcafe')
  end

end
