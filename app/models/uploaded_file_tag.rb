class UploadedFileTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :uploaded_file
end
