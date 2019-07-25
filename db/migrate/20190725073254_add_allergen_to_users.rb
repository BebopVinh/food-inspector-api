class AddAllergenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :allergen, :string
  end
end
