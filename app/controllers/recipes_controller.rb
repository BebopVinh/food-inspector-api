class RecipesController < ApplicationController
   def create
      query = params[:recipe].downcase.gsub(" ", "-")

      conn = Faraday.new(
         url: "https://api.edamam.com",
         params: {
            app_id: 'dc035cbf',
            app_key: ENV["Edamam_KEY"],
            from: 0,
            to: 9
         },
         headers: {'Content-Type' => 'application/json'}
      )
      resp = conn.get('search') do |req|
         req.params['q'] = query
      end

      resp = JSON.parse(resp.body)["hits"]
      render json: resp
   end
end
