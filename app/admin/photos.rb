ActiveAdmin.register Photo do
  show do
    attributes_table do
      row :description
      row :image do |photo|
        image_tag ad.image.url
      end
    end
    active_admin_comments
  end

  form do |f|
    inputs 'Details' do
      input :description
      input :image
      input :aasm_state, label: 'Вабрать статус', as: :select, collection: photo.aasm.states(permitted: true).map(&:name)
      input :aasm_state, input_html: { disabled: true },label: 'Текущий статус'
    end
    actions
  end
end

#f.object.aasm.states(permitted: true).map(&:name)
#photo.aasm.states(permitted: true).map(&:name)