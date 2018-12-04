class ReadyImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  version :little do
    process resize_to_fit: [300, 300]
  end

  version :medium do
    process resize_to_fit: [600, 600]
  end

  version :thumb do
    process resize_to_fit: [900, 900]
  end
end
