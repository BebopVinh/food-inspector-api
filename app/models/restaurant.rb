class Restaurant < ApplicationRecord
   def self.clean_results(results)
      restaurants = []
      results["result"]["data"].each do |r|
         cleaner = r.slice("address", "restaurant_phone", "restaurant_id", "menus", "restaurant_name")
         restaurants << cleaner
      end
      restaurants
   end
end
