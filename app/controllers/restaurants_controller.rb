class RestaurantsController < ApplicationController
   def get_coordinates
      url = URI.parse("")
   end

   def create
      coords = get_coordinates(params[:location])
      binding.pry
      url = URI.parse("https://us-restaurant-menus.p.rapidapi.com")
      resp = Faraday.get(url + "/restaurants/search") do |req|
         req.headers['X-RapidAPI-Host'] = "us-restaurant-menus.p.rapidapi.com"
         req.headers['X-RapidAPI-Key'] = ENV["RapidAPI_KEY"]
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