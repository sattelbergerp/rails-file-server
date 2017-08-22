class UploadedFilesController < ApplicationController

  before_action :set_uploaded_file, only: [:show, :download, :edit, :update, :destroy]

  def index
    @uploaded_files = UploadedFile.all
  end

  def new
    @uploaded_file = UploadedFile.new
  end

  def create
    @uploaded_file = current_user.uploaded_files.build(description: params[:uploaded_file][:description])
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
    @uploaded_file.update(description: params[:uploaded_file][:description])
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
  def set_uploaded_file
    @uploaded_file = UploadedFile.find_by(id: params[:id])
  end

end
