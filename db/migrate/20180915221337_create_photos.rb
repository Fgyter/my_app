class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :description
      t.decimal :price, :decimal, precision: 8, scale: 2
      
      t.timestamps
    end
  end
end
