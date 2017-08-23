class UploadedFile < ActiveRecord::Base

  belongs_to :user
  has_many :uploaded_file_tags
  has_many :tags, through: :uploaded_file_tags

  def tags_str=(tagsStr)
    tags.clear
    tagsStr.split(',').each do |tag|
      tags << Tag.find_or_create_by(name: tag.strip)
    end
  end

  def tags_str
    return tags.collect{ |t| t.name }.join(', ')
  end

  def related
    UploadedFile.where.not(id: id).joins(:tags).where('tags.name' => tags.collect{ |t| t.name }).group(:id).order('COUNT(uploaded_files.id) DESC')
  end

end
