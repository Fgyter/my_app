class AddAttachmentReadyImageToPhotos < ActiveRecord::Migration[5.2]
  def self.up
    change_table :photos do |t|
      t.attachment :ready_image
    end
  end

  def self.down
    remove_attachment :photos, :ready_image
  end
end
