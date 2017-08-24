class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :uploaded_file_id
      t.integer :parent_id
      t.integer :user_id
      t.string :content
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
