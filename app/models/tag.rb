class Tag < ActiveRecord::Base
  has_many :uploaded_file_tags
  has_many :uploaded_files, through: :uploaded_file_tags
end
