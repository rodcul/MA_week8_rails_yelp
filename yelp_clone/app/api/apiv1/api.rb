module API
  class APIV1 < Grape::API
    version 'v1', using: :header, vendor: 'yelp'
    format :json
    prefix :api

    resource :restaurants do
      desc "List all Restaurants"

      get do
        Restaurant.all
      end

      get '/:restaurant_id/reviews' do
        @restaurant = Restaurant.find(params[:restaurant_id])
        @restaurant.reviews
      end
    end
  end
end
