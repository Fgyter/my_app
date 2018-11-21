class AddReadyImageToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :ready_image, :string
  end
end
