ActiveAdmin.register Photo do
  permit_params :description, :aasm_state, :image, :price, :ready_image

  show do
    attributes_table do
      row :description
      row :image do |photo|
        image_tag photo.image.url
      end
      row :ready_image do |photo|
        image_tag photo.ready_image.url
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    inputs 'Details' do
      input :description
      input :image, label: 'Image order'
      input :ready_image, label: 'Image admin'
      input :aasm_state, label: 'Type status', as: :select, 
             collection: [f.object.aasm_state] + f.object.aasm.states(permitted: true).map(&:name)
      input :price
    end
    actions
  end
end
