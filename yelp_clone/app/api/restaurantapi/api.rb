module API
  class Restaurantapi < Grape::API
    version 'v1', using: :header, vendor: 'yelp'
    format :json
    prefix :api

    resource :restaurants do
      desc "List all Restaurants"

      get do
        Restaurant.all
      end
    end
  end
end
