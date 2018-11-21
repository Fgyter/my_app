class AddAttachmentReadyPhotoToPhotos < ActiveRecord::Migration[5.2]
  def self.up
    change_table :photos do |t|
      t.attachment :ready_photo
    end
  end

  def self.down
    remove_attachment :photos, :ready_photo
  end
end
