class UploadedFile < ActiveRecord::Base

  belongs_to :user
  has_many :uploaded_file_tags
  has_many :tags, through: :uploaded_file_tags

end
