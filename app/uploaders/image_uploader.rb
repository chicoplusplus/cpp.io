class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  def store_dir
    "uploads/#{model.class.name.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process :resize_to_limit => [500, 500]
  end

  version :medium do
    process :crop
    process :resize_to_fill => [150,150]
  end

  version :thumb do
    process :crop
    process :resize_to_fill => [75,75]
  end

  version :tiny do
    process :crop
    process :resize_to_fill => [25,25]
  end

  def crop
    test_method = "crop_#{mounted_as}?".to_sym
    if model.respond_to?(test_method) && model.send(test_method)
      resize_to_limit 500, 500 # redo resize so coords match up
      manipulate! do |img|
        x = model.send("#{mounted_as}_crop_x").to_i
        y = model.send("#{mounted_as}_crop_y").to_i
        w = model.send("#{mounted_as}_crop_w").to_i
        h = model.send("#{mounted_as}_crop_h").to_i
        img.crop("#{w}x#{h}+#{x}+#{y}")
        img
      end
    end
  end

  def default_url
    "/assets/avatars/missing_#{version_name}.png"
  end
end

