class AddUserIdToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :user_id, :integer
    # данной миграцией создаеться новая колонка с названием :user_id , значение :integer = целое цисло
    add_index :photos, :user_id
  end
end
