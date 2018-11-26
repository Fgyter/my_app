class AddTokenToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :token, :string
  end
end
