class UploadedFile < ActiveRecord::Base

  belongs_to :user
  has_many :uploaded_file_tags
  has_many :tags, through: :uploaded_file_tags

  def tags_str=(tagsStr)
    tagsStr.split(',').each do |tag|
      tags << Tag.find_or_create_by(name: tag.strip)
    end
  end

  def tags_str
    return tags.join(', ')
  end

end
