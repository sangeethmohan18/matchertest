defmodule App.Documents do
  require IEx
  use Waffle.Definition

  # Include ecto support (requires package waffle_ecto installed):
  # use Waffle.Ecto.Definition

  @acl :private

  @versions [:original]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # def bucket({_file, scope}) do
  #   scope.bucket || bucket()
  # end

  # Whitelist file extensions:
  # def validate({file, _}) do
  #   file_extension = file.file_name |> Path.extname() |> String.downcase()
  #
  #   case Enum.member?(~w(.jpg .jpeg .gif .png), file_extension) do
  #     true -> :ok
  #     false -> {:error, "invalid file type"}
  #   end
  # end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end

  # Override the persisted filenames:
  def filename(version, {file, _scope}) do
    file.file_name
  end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "uploads/user/documents/#{scope.id}/"
  end

  # defp convert_filename(file, version) do
  #   "#{version}-#{file.file_name}"
  # end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: MIME.from_path(file.file_name)]
  # end
end
