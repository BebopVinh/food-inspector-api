class RestaurantsController < ApplicationController
   def create
      url = URI.parse("https://us-restaurant-menus.p.rapidapi.com")
      resp = Faraday.get(url + "/restaurants/search") do |req|
         req.headers['X-RapidAPI-Host'] = "us-restaurant-menus.p.rapidapi.com"
         req.headers['X-RapidAPI-Key'] = ENV["RapidAPI_KEY"]
         req.params["lat"] = params["lat"]
         req.params["lon"] = params["lng"]
         req.params["distance"] = 10
         req.params["fullmenu"] = true
      end

      json = JSON.parse(resp.body)
      render json: json
   end
end