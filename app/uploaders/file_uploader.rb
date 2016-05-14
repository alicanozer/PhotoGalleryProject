# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support
  #     include CarrierWave::RMagick
  #     include CarrierWave::ImageScience
  include CarrierWave::MiniMagick
  storage :file


  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #{}"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    ENV['STORAGE_PATH'] + "/files/#{model.album.path}"
  end

  # Create different versions of your uploaded files
  version :collection do
    process :resize_to_fill => [200, 200]

    def store_dir
      ENV['STORAGE_PATH'] + "/thumbs/#{model.album.path}"
    end
  end
  version :album do
    process :resize_to_fill => [100, 100]

    def store_dir
      ENV['STORAGE_PATH'] + "/thumbs/#{model.album.path}"
    end
  end
  version :preview do
    process :resize_to_fit => [210, 210]

    def store_dir
      ENV['STORAGE_PATH'] + "/thumbs/#{model.album.path}"
    end
  end
  version :single do
    process :resize_to_limit => [950, 950]

    def store_dir
      ENV['STORAGE_PATH'] + "/thumbs/#{model.album.path}"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded,
  # for images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png bmp tiff)
  end

end