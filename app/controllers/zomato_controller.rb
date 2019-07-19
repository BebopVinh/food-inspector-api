class ZomatoController < ApplicationController
   def create
      conn = Faraday.new(
         url: 'https://developers.zomato.com/api/v2.1/geocode',

         headers: {
            'Content-Type': 'application/json',
            'user-key': 'ede3852ed1c7062dab6b55dd8cff2417'
         }
      )  

      coordinates = params[:zomato][:location].split(",")
      latitude = coordinates.first.strip.to_f
      longitude = coordinates.last.strip.to_f
      
      resp = conn.get('') do |req|
         req.params['lat'] = latitude
         req.params['lon'] = longitude
      end

      resp = JSON.parse(resp.body)
      resp = resp["nearby_restaurants"]

      render json: resp
   end
end
