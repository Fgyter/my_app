class AddPriceCreatePhotos < ActiveRecord::Migration[5.2]
  def change
  	add_column :photos, :price, :decimal, precision: 8, scale: 2
  end
end
