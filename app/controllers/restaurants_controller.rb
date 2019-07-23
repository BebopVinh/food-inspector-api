class RestaurantsController < ApplicationController
   def get_coordinates(location)
      conn = Faraday.new(
         url: `http://www.mapquestapi.com/geocoding/v1/address`,
         params: {
            key: "EF1AZhfMvqfQK2Z2J2biWZf0lBvl9qsH",
            location: location.downcase
         },
         headers: {'Content-Type' => 'application/json'}
      )

      resp = conn.get('') do |req|
      end

      puts resp

      coords = JSON.parse(resp.body)["results"][0]["locations"][0]["latLng"]
      binding.pry
   end


   def create
      coords_hash = get_coordinates(params[:location])
      binding.pry
   end
end