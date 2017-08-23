class CreateUploadedFileTags < ActiveRecord::Migration
  def change
    create_table :uploaded_file_tags do |t|
      t.integer :tag_id
      t.integer :uploaded_file_id

      t.timestamps null: false
    end
  end
end
