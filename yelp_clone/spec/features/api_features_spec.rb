require 'rails_helper'

describe "API" , :type => :api do

describe "GET" do

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

describe "POST" do

  it "creates a restaurant" do
    params = {name: "Trade"}
    post "/api/restaurants", params.to_json, :formate =>:json
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['name']).to eq('Trade')
  end

end

end

describe "PUT" do

  it "updates a restaurant" do
    params = {id: @restaurant.id, name: "Hooters"}
    put "/api/restaurants", params.to_json, :formate =>:json
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['name']).to eq('Hooters')
  end

end

end
