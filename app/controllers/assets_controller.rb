class AssetsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @assets = current_user.assets
  end

  def new
    @asset = current_user.assets.new
  end

  def create
    @asset = current_user.assets.new(params[:asset])
    if @asset.save
      redirect_to root_url,  flash[:notice]  => "Successfully uploaded song."
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = current_user.assets.find(params[:id])
  end

  def update
    @asset = current_user.assets.find(params[:id])
    if @asset.update_attributes(params[:asset])
      redirect_to root_url, flash[:notice]  => "Successfully updated song."
    else
      render :action => 'edit'
    end
  end

  def show
    @asset = current_user.assets.find(params[:id])
    @asset.destroy
    flash[:notice] = "Successfully deleted song."

    redirect_to root_url
  end


  #this action will let the users download the files (after a simple authorization check)
  def get
    asset = current_user.assets.find_by_id(params[:id])
    if asset
      send_file asset.uploaded_file.path, :type => asset.uploaded_file_content_type
    else
      flash[:error] = "This is not your song!"
      redirect_to root_url
    end
  end
end
