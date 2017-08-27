class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :uploaded_file
  belongs_to :parent, class_name: 'Comment'
  has_many :comments, foreign_key: :parent_id

  def self.top_level
    where(parent_id: nil)
  end

  def self.best
    order(score: :desc)
  end
end
