ActiveAdmin.register Photo do
  permit_params :description, :aasm_state, :image

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
    inputs 'Details' do
      input :description
      input :image
      input :aasm_state, label: 'Вабрать статус', as: :select, collection: [photo.aasm_state] + photo.aasm.states(permitted: true).map(&:name)
    end
    actions
  end
end

#f.object.aasm.states(permitted: true).map(&:name)
#photo.aasm.states(permitted: true).map(&:name) [:verified, :archived, :rejected]