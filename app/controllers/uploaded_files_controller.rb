class UploadedFilesController < ApplicationController

  before_action :set_uploaded_file, only: [:show, :download]
  before_action :set_uploaded_file_for_modify, only: [:edit, :update, :destroy]

  def index
    @uploaded_files = UploadedFile.all
  end

  def new
    render status: 403, text: 'You must create an account to upload files' if !current_user
    @uploaded_file = UploadedFile.new
  end

  def create
    render status: 403, text: 'You must create an account to upload files' if !current_user
    @uploaded_file = current_user.uploaded_files.build(uploaded_file_params)
    file = params[:uploaded_file][:file]
    @uploaded_file.file_type = file.content_type
    @uploaded_file.size = file.size
    @uploaded_file.name = file.original_filename
    if @uploaded_file.save
      File.open(Rails.root.join('public', 'uploads', "uploaded_file_#{@uploaded_file.id}"), 'wb') do |out_file|
        out_file.write(file.read)
      end
      @uploaded_file.path = "uploads/uploaded_file_#{@uploaded_file.id}"
      @uploaded_file.save
      redirect_to uploaded_file_path(@uploaded_file)
    end
  end

  def update
    @uploaded_file.update(uploaded_file_params)
    redirect_to uploaded_file_path(@uploaded_file)
  end

  def destroy
    FileUtils.rm_f "#{Rails.root}/public/#{@uploaded_file.path}"
    @uploaded_file.delete
    redirect_to uploaded_files_path
  end

  def download
    send_file("#{Rails.root}/public/#{@uploaded_file.path}", filename: @uploaded_file.name, type: @uploaded_file.file_type)
  end

  private
  def uploaded_file_params
    params.require(:uploaded_file).permit(:tags_str, :description)
  end
  def set_uploaded_file
    @uploaded_file = UploadedFile.find_by(id: params[:id])
  end

  def set_uploaded_file_for_modify
    @uploaded_file = UploadedFile.find_by(id: params[:id])
    @uploaded_file = nil if @uploaded_file.user != current_user
    render status: 404, text: "Not Found" if !@uploaded_file
  end

end
