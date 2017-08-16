class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.string :name
      t.string :description
      t.integer :size
      t.integer :user_id
      t.string :type

      t.timestamps null: false
    end
  end
end
