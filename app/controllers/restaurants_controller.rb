class RestaurantsController < ApplicationController
   def get_coordinates(location)
      location = location.downcase.gsub(/\s+/, "")
      conn = Faraday.new(
         url: `http://www.mapquestapi.com/geocoding/v1`,
         params: {
            key: "EF1AZhfMvqfQK2Z2J2biWZf0lBvl9qsH"
         },
         headers: {'Content-Type' => 'application/json'}
      )

      resp = conn.get('address') do |req|
         req.params['location'] = location
      end
      resp = JSON.parse(resp.body)
   end


   def restaurants
      coords_hash = get_coordinates(params[:location])
   end
end