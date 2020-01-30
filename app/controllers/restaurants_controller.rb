class RestaurantsController < ApplicationController
   def get_coordinates(location)
      url = URI.parse("http://www.mapquestapi.com/geocoding/v1/address")
      resp = Faraday.get(url) do |req|
         req.params["key"] = ENV["MAPQUEST_KEY"]
         req.params["location"] = location
      end
      data = JSON.parse(resp.body)
      return data["results"].first["locations"].first["latLng"]
   end

   def create
      coords = get_coordinates(params[:location])
      url = URI.parse("https://us-restaurant-menus.p.rapidapi.com")
      resp = Faraday.get(url + "/restaurants/search") do |req|
         req.headers['X-RapidAPI-Host'] = "us-restaurant-menus.p.rapidapi.com"
         req.headers['X-RapidAPI-Key'] = ENV["RapidAPI_KEY"]
         req.params["lat"] = coords["lat"]
         req.params["lon"] = coords["lng"]
         req.params["distance"] = 5
         req.params["fullmenu"] = true
      end

      binding.pry
      restaurants = JSON.parse(resp.body)
      render json: restaurants
   end


end