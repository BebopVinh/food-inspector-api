class RestaurantsController < ApplicationController
   def create
      url = URI.parse("https://us-restaurant-menus.p.rapidapi.com")
      resp = Faraday.get(url + "/restaurants/search") do |req|
         req.headers['X-RapidAPI-Host'] = "us-restaurant-menus.p.rapidapi.com"
         req.headers['X-RapidAPI-Key'] = "5dce6a8d6bmshd239c74b22371eep1177d5jsn1ab7356b63e0"
         req.params["lat"] = params[:lat]
         req.params["lon"] = params[:lng]
         req.params["distance"] = 10
         req.params["fullmenu"] = true
      end

      json = JSON.parse(resp.body)
      binding.pry
      render json: json
      
   end
end