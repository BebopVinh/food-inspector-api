class RestaurantsController < ApplicationController
   def get_coordinates(location)
      url = URI.parse("http://www.mapquestapi.com/geocoding/v1/address")
      location = location.downcase.gsub(/\s*,\s/, ",");
      resp = Faraday.get(
         url,
         {key: "EF1AZhfMvqfQK2Z2J2biWZf0lBvl9qsH", location: location},
         {'Accept' => 'application/json'}
         )
      coords = JSON.parse(resp.body)['results'].first['locations'].first['latLng']
   end


   def create
      coords = get_coordinates(params[:location])
      url = URI.parse("https://us-restaurant-menus.p.rapidapi.com")
      resp = Faraday.get(url + "/restaurants/search") do |req|
         req.headers['X-RapidAPI-Host'] = "us-restaurant-menus.p.rapidapi.com"
         req.headers['X-RapidAPI-Key'] = "a65e0a6ec9mshe629e4a46efeb13p1f5432jsn0b66f46daafb"
         req.params["lat"] = coords["lat"]
         req.params["lon"] = coords["lng"]
         req.params["distance"] = 5
         req.params["fullmenu"] = true
      end

      json = JSON.parse(resp.body)
      restaurants = Restaurant.clean_results(json)
      
      render json: restaurants
      
   end
end