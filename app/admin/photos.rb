ActiveAdmin.register Photo do
  permit_params :description, :aasm_state, :image, :price

  show do
    attributes_table do
      row :description
      row :image do |photo|
      image_tag photo.image.url
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors #*f.object.errors.keys
    inputs 'Details' do
      input :description
      input :image
      input :aasm_state, label: 'Вабрать статус', as: :select, 
             collection: [f.object.aasm_state] + f.object.aasm.states(permitted: true).map(&:name)
      input :price
    end
    actions
  end
end
