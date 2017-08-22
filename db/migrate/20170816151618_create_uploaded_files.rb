class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.string :name
      t.string :description
      t.integer :size
      t.integer :user_id
      t.string :file_type

      t.timestamps null: false
    end
  end
end
