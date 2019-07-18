class ZomatoController < ApplicationController
   def index
      conn = Faraday.new(
         url: 'https://developers.zomato.com/api/v2.1/geocode',
         # params: {
         #    lat: 34.052235,
         #    lon: -118.243683
         # },
         headers: {
            'Content-Type': 'application/json',
            'user-key': 'ede3852ed1c7062dab6b55dd8cff2417'
         }
      )  

      resp = conn.get('') do |req|
         req.params['lat'] = 34.052235
         req.params['lon'] = -118.243683
      end

      render json: JSON.parse(resp.body)
   end
end
