ActiveAdmin.register Photo do
  show do
    attributes_table do
      row :title
      row :image do |ad|
        image_tag ad.image.url
      end
    end
    active_admin_comments
  end
end
