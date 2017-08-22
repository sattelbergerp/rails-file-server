class AddPathToUploadedFiles < ActiveRecord::Migration
  def change
    add_column :uploaded_files, :path, :string
  end
end
