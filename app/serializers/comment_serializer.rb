class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :score, :parent_id
  belongs_to :user
  attribute :comments do
    object.comments.collect do |comment|
      CommentSerializer.new(comment, each_serializer: CommentSerializer).to_json
    end
  end

end
