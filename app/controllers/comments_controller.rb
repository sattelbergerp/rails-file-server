class CommentsController < ApplicationController

  before_action :set_uploaded_file

  def index
    out=@uploaded_file.comments.best.collect do |comment|
      user = comment.user
      parent_id = comment.parent_id ? comment.parent_id : "null"
      "{\"content\":\"#{comment.content}\", \"parent_id\":#{parent_id}, \"score\":#{comment.score}, \"id\": #{comment.id}, \"user\":{\"username\":\"#{user.username}\"}}"
      #{}"{\"content\":\"#{comment.content}\", \"parent_id\":#{parent_id}, \"score\":#{comment.score}, \"id\": #{comment.id}}"
    end.join(', ')
    render json: "[#{out}]"
  end

  private
  def set_uploaded_file
    @uploaded_file = UploadedFile.find_by(id: params[:uploaded_file_id])
  end
end
